server <- function(input, output){
  data <- flights %>% 
    select(year, month, day, carrier, distance, dep_time, arr_time, air_time) %>%
    filter(carrier %in% c("AA", "UA", "DL", "B6", "MQ"))
  
  dataInput <- reactive({
    data %>% filter(carrier == input$carrierDropdown)
  })
  
  duration_stats <- reactive({
    
    d <- dataInput()
    d %>% group_by(year, month) %>% summarise(AvgDuration = mean(air_time, na.rm=T))
    
  })
  output$DT_table <- DT::renderDataTable(DT::datatable(duration_stats()), server = TRUE)
  
  output$ggplot_plot <- renderPlot({
    ggplot(data = dataInput(), aes(x = factor(month), y = air_time)) +
    geom_boxplot()
  })
  
  output$gganimate_plot <- renderImage({
    # A temp file to save the output.
    # This file will be removed later by renderImage
    outfile <- tempfile(fileext='.gif')
    
    # now make the animation
    p = ggplot(data = dataInput(), aes(x = factor(month), y = air_time)) +
      geom_boxplot() +
      transition_time(month) # New
    
    anim_save("outfile.gif", animate(p)) # New
    
    # Return a list containing the filename
    list(src = "outfile.gif",
         contentType = 'image/gif',
         width = '100%',
         height = 600
         # alt = "This is alternate text"
    )}, deleteFile = TRUE)
}