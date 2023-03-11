import { PrismaClient } from '@prisma/client'
import * as fs from 'fs'

interface Table {
    table_name: string;
    deleteMany: () => Promise<any>;
}

interface TypeList {
    [key: string]: string[]
}

interface TypeListAction {
    deleteMany: () => Promise<any>;
    createMany: () => Promise<any>;
    create: any;
}

interface User {
    id: Number
}

const prisma = new PrismaClient()
async function main() {
    await deleteAllTable();
    const user: User = await createUser();
    await seedTables(user);
}

async function deleteAllTable() {
    const tables = await prisma.$queryRaw<Table[]>`SELECT table_name FROM information_schema.tables WHERE table_schema='public';`
    for (const table of tables) {
        if (table.table_name === '_prisma_migrations')
            continue;
        const model = prisma[table.table_name as keyof typeof prisma] as TypeListAction;
        await model?.deleteMany()
    }
}

const createUser = async (): Promise<User> => {
    const first = await prisma.user.findFirst()
    if (first != null) {
        await prisma.user.deleteMany();
    }
    const user = await prisma.user.create({
        data: {
            name: "test-1",
            email: "test1@gmail.com",
            role: "ADMIN",
            password: "test-1-password",
            logged_in: false,
            description: 'Sample Test User Description',
        }
    })
    return { id: user.id }
}
async function seedTables(user: User) {
    const seeds = await DeclareEachJSON();
    const tables = Object.keys(seeds);
    tables.forEach(async (value, index) => {
        const model = prisma[value as keyof typeof prisma] as TypeListAction;
        seeds[value].forEach(async (value: any, index: Number) => {
            await model.create({
                data: { ...value, created_by_id: user.id, updated_by_id: user.id }
            })
        })
    })
}

// Get all json files from seed folder
const DeclareEachJSON = async (): Promise<TypeList> => {
    const readPath = './prisma/seed/'
    const fileNames = fs.readdirSync(readPath).filter(file => file.match(/\.json$/))
    const typeList: TypeList = {}
    fileNames.forEach((fileName: string) => {
        let typeName = fileName.match(/(^.*?)\.json/)
        if (typeName) {
            typeList[typeName[1]] = JSON.parse(fs.readFileSync(readPath + fileName, 'utf8').toString())
        }
    })
    return typeList
}


main().catch((e) => {
    console.log(e.message)
}).finally(async () => {
    await prisma.$disconnect();
})
