/**
 * This is not a production server yet!
 * This is only a minimal backend to get started.
 */

import { Logger } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';

import { AppModule } from './app/app.module';
import { DataService } from './data';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  //Prisma
  const dataService = app.get(DataService);
  await dataService.enableShutdownHooks(app);

  const globalPrefix = 'api';
  app.setGlobalPrefix(globalPrefix);
  const port = process.env.PORT || 3333;
  const config = new DocumentBuilder()
    .setTitle('GoCar By Thư Mai')
    .setDescription('The gocar API description')
    .setVersion('1.0')
    .addTag('GoCar')
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup(`${globalPrefix}/swagger`, app, document);
  await app.listen(port);
  Logger.log(
    `🚀 Application is running on: http://localhost:${port}/${globalPrefix}`
  );
}

bootstrap();
