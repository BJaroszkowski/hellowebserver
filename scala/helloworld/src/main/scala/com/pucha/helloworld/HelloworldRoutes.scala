package com.pucha.helloworld

import cats.effect.Sync
import cats.syntax.all.*
import org.http4s.HttpRoutes
import org.http4s.dsl.Http4sDsl

object HelloworldRoutes:

  def baseRoutes[F[_]: Sync](): HttpRoutes[F] =
    val dsl = new Http4sDsl[F]{}
    import dsl.*
    HttpRoutes.of[F] {
    case GET -> Root => {
      Ok("Hello mad world!")
    }
  }

