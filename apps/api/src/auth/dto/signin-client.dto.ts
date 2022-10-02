import { ApiProperty } from '@nestjs/swagger';

export class SignInClientDto {
  @ApiProperty()
  username: string;

  @ApiProperty()
  password: string;
}
