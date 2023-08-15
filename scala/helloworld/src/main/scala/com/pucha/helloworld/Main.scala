package com.pucha.helloworld

import cats.effect.{IO, IOApp}

object Main extends IOApp.Simple:
  val run = HelloworldServer.run[IO]
