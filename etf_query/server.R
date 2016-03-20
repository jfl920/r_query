shinyServer(function(input, output, session) {
  last_cache <- NULL
  
  observeEvent(input$action_query, {
    tryCatch({
      res <- dbSendQuery(conn, isolate(input$code_query))
      data <- fetch(res, n = -1)
      if(nrow(data) == 0) stop("no data returned")
      output$output_query <- renderUI({
        list(
          downloadButton("query_download", "download results"),
          dataTableOutput("query_data")
        )
      })
      output$query_data <- renderDataTable(data, options = list(
        scrollX = T,
        pageLength = 25,
        paging = T,
        searching = F
      ))
      last_cache <<- data
    }, error = function(e) {
      output$output_query <- renderUI(verbatimTextOutput("error_output"))
      output$error_output <- renderPrint(e)
    })
  })
  
  output$query_download <- downloadHandler(
    filename = function() {
      sprintf("%s.csv", paste(sample(c(0:9, letters, LETTERS), 12, replace=T), collapse = ""))
    },
    content = function(con) {write.csv(last_cache, con, row.names = F)}
  )
  
  observeEvent(input$select_table_info, {
    tbl <- input$select_table_info
    stmt <- sprintf("SELECT column_name, data_type, character_maximum_length FROM information_schema.columns WHERE table_name = '%s'", tbl)
    schema <- dbGetQuery(conn, stmt) #TODO: error check here
    output$table_schema <- renderDataTable(schema, options = list(
      scrollX = T,
      paging = F,
      searching = F
    ))
  })
})
