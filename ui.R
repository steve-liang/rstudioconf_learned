ui <- material_page(
  
  material_dropdown(input_id = "carrierDropdown", label = "Select Dropdown", 
                    choices =  c("American Airline" = "AA", 
                                "United Airline" = "UA", 
                                "Delta Airline" = "DL", 
                                "JetBlue Airways" = "B6", 
                                "American Eagle" = "MQ")),
  
  material_tabs(
    tabs = c("DT" = "DT_tab", "gt" = "gt_tab", "ggplot" = "ggplot_tab", "gganimate" = "gganimate_tab")
  ),
  
  material_tab_content(tab_id = "DT_tab",
                       material_row(
                         DT::dataTableOutput("DT_table")
                       )
  ),
  material_tab_content(tab_id = "ggplot_tab",
                       material_row(
                         plotOutput("ggplot_plot")
                       )
  ),
  material_tab_content(tab_id = "gganimate_tab",
                       material_row(
                         imageOutput("gganimate_plot")
                       )
  )
)