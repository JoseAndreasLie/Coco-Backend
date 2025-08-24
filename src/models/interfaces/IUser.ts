export interface IUser {
    id: string;
    username: string;
    name: string;
    email: string;
    password_hash?: string;
    created_at?: Date;
    updated_at?: Date;
    deleted_at?: Date;
}