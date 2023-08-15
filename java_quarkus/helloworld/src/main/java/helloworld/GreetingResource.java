package helloworld;

import io.quarkus.vertx.web.Route;
import io.vertx.ext.web.RoutingContext;

import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class GreetingResource {

    @Route(path = "/", methods = Route.HttpMethod.GET)
    public void landing(RoutingContext rc) {
        rc.response().end("Hello Mad World!");
    }
}
