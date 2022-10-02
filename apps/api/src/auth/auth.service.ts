import { BadRequestException, Injectable } from '@nestjs/common';
import { DataService } from '../data';
import { JwtService } from '@nestjs/jwt';
import { CreateClientDto, SignInClientDto } from './dto';
import { Client } from '.prisma/client';

export interface User {
  username: string;
  password: string;
  name?: string;
  phone?: string;
  address?: string;
}

export interface CreateClient {
  username: string;
  password: string;
  name: string;
  phone: string;
  address: string;
}

@Injectable()
export class AuthService {
  constructor(
    private dataService: DataService,
    private jwtService: JwtService
  ) {}

  async findUser(username: string): Promise<Client> {
    const client = await this.dataService.client.findUnique({
      where: {
        username,
      },
    });
    return client;
  }

  async createClient(dto: CreateClientDto): Promise<Client> {
    const user = await this.findUser(dto.username);
    if (user) {
      throw new BadRequestException('Username already exists');
    }
    const result = await this.dataService.client.create({
      data: dto,
    });
    return result;
  }

  async clientSignIn(dto: SignInClientDto): Promise<any> {
    const { username, password } = dto;
    const user = await this.findUser(username);
    if (user && user.password === password) {
      const { password, ...userInfo } = user;
      return { access_token: this.jwtService.sign(userInfo) };
    }
    throw new BadRequestException('Username and password invalid');
  }
}
