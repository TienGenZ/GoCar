import { Body, Controller, Post } from '@nestjs/common';
import { AuthService } from './auth.service';
import { CreateClientDto, SignInClientDto } from './dto';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('/client/login')
  async clientSignIn(@Body() client: SignInClientDto) {
    return await this.authService.clientSignIn(client);
  }

  @Post('/client/sign-up')
  async createClient(@Body() client: CreateClientDto) {
    return await this.authService.createClient(client);
  }
}
