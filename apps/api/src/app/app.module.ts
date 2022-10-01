import { Module } from '@nestjs/common';
import { AuthModule } from '../auth/auth.module';
import { DataModule } from '../data';

@Module({
  imports: [DataModule, AuthModule],
})
export class AppModule {}
