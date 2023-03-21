import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {

    app.databases.use(.postgres(
        hostname: "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
        username: "judealatawi",
        password: "",
        database:"galartwo"
    ), as: .psql)

    app.migrations.add(CreateGalary())
    try app.autoMigrate().wait()

    // register routes
    try routes(app)
}
