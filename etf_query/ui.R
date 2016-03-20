shinyUI(
  bootstrapPage(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "jquery.splitter.css"),
      tags$link(rel = "stylesheet", type = "text/css", href = "etf_query.css")
    ),
#    headerPanel("ETF querybuilder"),
    div(
      class = "container-fluid",
      div(
        class = "row-fluid split-panel",
        div(
          class = "col-sm-6",
          h4("Source code"),
          aceEditor("code_query", mode = "sql", value = "", autoComplete = "live"),
          actionButton("action_query", "Run query"),
          hr(),
          selectInput("select_table_info", "select table to inspect: ", choices = db_tables$table_name),
          dataTableOutput("table_schema")
        ),
        div(
          class = "col-sm-6",
          h4("Output"),
          uiOutput("output_query")
        )
      )
    ),
    tags$script(src = "jquery.splitter.js"),
    tags$script(src = "etf_query.js")
  )
)
