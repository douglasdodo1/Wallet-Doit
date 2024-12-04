import * as yup from "yup";

export const UserSchema = () =>{
    return yup.object({
        cpf: yup.string().min().required(),
        name: yup.string().required(),
        email: yup.string().email().required(),
        password: yup.string().min(0).required(),
        phone: yup.string().min(10).required(),
        sale: yup.number().default(0),
        credit: yup.number().default(0),
        credit_used: yup.number().default(0), 
    })
}