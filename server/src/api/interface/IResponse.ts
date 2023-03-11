interface IResponse{
  status: Number,
  success: Boolean,
  message: Array<{ value: String, message: String }>;
  route: URL | null,
  Roles: RoleEnum,
  Id: Number | null;
};

enum RoleEnum {
  USER,
  STUDENT,
  ADMIN
}