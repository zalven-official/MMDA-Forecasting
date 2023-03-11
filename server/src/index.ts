import http from 'http'
import express, { Request, Response } from 'express'
import cors from 'cors'
import morgan from 'morgan'
const PORT = process.env.PORT || 4000;
const app = express()

const routes = require('./api/routes/index')

app.use(cors())
app.use(express.json());
app.use(morgan("dev"));

app.get("/", async (request: Request, response: Response) => {
    response.send("Welcome")
})

app.use('/api', routes)




app.listen(PORT, () => {
    console.log(`App is running on http://localhost:${PORT}`)
})