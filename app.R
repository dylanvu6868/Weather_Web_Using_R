# official
library(shiny)
library(leaflet)
library(jsonlite)
library(ggplot2)
library(tidyverse)
library(shinydashboard)
library(dplyr)
library(shinyMatrix)
library(plotly)

ui <- dashboardPage(
  dashboardHeader(
    title = "Weather VHD",
    tags$li(
      class = "dropdown",
      style = "padding: 4px; font-size: 30px; color: white;",
      textOutput("current_time")
    )
  ),
  dashboardSidebar(
    tags$div(
      style = "text-align: center; padding: 10px;",
      tags$p("Vũ Hải Dương", style = "font-weight: bold; font-size: 30px; margin-top: 5px;")
    ),
    sidebarMenu(
      menuItem("Weather", tabName = "weather"),
      menuItem("Forecast", tabName = "forecast")
    )
  ),
  dashboardBody(tags$head(
    tags$head(tags$style(HTML("
    .main-header, .main-header .navbar {
  background: linear-gradient(45deg, #CDE0C9, #2C6975) !important;
  color: white !important;
  border-bottom: none !important;
}

.main-header .logo {
  background: linear-gradient(45deg, #CDE0C9, #2C6975) !important;
  color: white !important;
  font-weight: bold;
}

.main-sidebar {
  background: linear-gradient(45deg, #CDE0C9, #2C6975) !important;
}

.content-wrapper {
  background: linear-gradient(45deg, #CDE0C9, #2C6975) !important;
}

.box {
  border-radius: 15px !important; 
  box-shadow: 3px 3px 10px rgba(0,0,0,0.2); 
  overflow: hidden; 
  background: linear-gradient(45deg, #CDE0C9, #2C6975) !important; 
  color: white !important;
}

.sidebar-menu > li.active > a {
  background: linear-gradient(45deg, #CDE0C9, #2C6975) !important;
  color: white !important;
  font-weight: bold;
}

.sidebar-menu > li:hover > a {
  background: linear-gradient(45deg, #CDE0C9, #2C6975) !important;
  color: white !important;
}

.sidebar-menu > li > a {
  color: white !important;
}

.sidebar-menu {
  border: none !important;
}
    "))),
    tags$style(HTML(
      '
    .content-wrapper {
      background: linear-gradient(45deg, #000000, #444444, #888888); 
      background-size: cover;
      background-position: center;
      background-attachment: fixed;
    }
    '
    ))
  ),
  tabItems(
    tabItem(tabName = "weather",
            fluidRow(
              column(
                width = 12,
                tags$div(
                  style = "display: flex; flex-direction: column; align-items: center;",
                  
                  # Phần thông tin thời tiết
                  tags$div(
                    class = "weather-info",
                    style = "display: flex; flex-wrap: wrap; justify-content: center; gap: 20px;",
                    
                    tags$div(
                      p("Current Weather", class = "custom-text", 
                        style = "font-weight: bold;font-size:90px; color: white; text-align: center;")
                    ),
                    
                    tags$div(
                      style = "font-weight: bold;display: flex; align-items: center;font-size:70px;color:white",
                      tags$i(class = "fas fa-map-marker-alt custom-icon"),
                      tags$div(tags$span(textOutput("location"), class = "custom-text-output1")),
                      tags$i(class = "fas fa-cloud-sun-rain custom-cloud1"),
                    ),
                    
                    tags$div(
                      style = "font-weight: bold;display: flex; align-items: center;font-size:50px;color:white",
                      tags$i(class = "fas fa-temperature-high custom-icon-temp"),
                      p("Current Temperature: ", class = "custom-text-output2"),
                      tags$div(tags$span(textOutput("temperature"), class = "custom-text-temp")),
                    ),
                    
                    # Các box thông tin
                    box(
                      width = 4,
                      style = "font-size:34px; text-align: center; font-family: 'Poppins', sans-serif;",
                      title = div(tags$i(class = "fa-solid fa-droplet box-icon"), "Humidity"),
                      textOutput("humidity"),
                      background = "aqua"
                    ),
                    
                    box(
                      width = 4,
                      style = "font-size:34px; text-align: center; font-family: 'Poppins', sans-serif;",
                      title = div(tags$i(class = "fas fa-temperature-high box-icon"), "Feels Like"),
                      textOutput("feels_like"),
                      background = "red"
                    ),
                    
                    box(
                      width = 4,
                      style = "font-size:34px; text-align: center; font-family: 'Poppins', sans-serif;",
                      title = div(tags$i(class = "fas fa-smog box-icon"), "Weather Condition"),
                      textOutput("weather_condition"),
                      background = "olive"
                    ),
                    
                    box(
                      width = 4,
                      style = "font-size:34px; text-align: center; font-family: 'Poppins', sans-serif;",
                      title = div(tags$i(class = "fas fa-eye box-icon"), "Visibility"),
                      textOutput("visibility"),
                      background = "teal"
                    ),
                    
                    box(
                      width = 4,
                      style = "font-size:34px; text-align: center; font-family: 'Poppins', sans-serif;",
                      title = div(tags$i(class = "fas fa-wind box-icon"), "Wind Speed"),
                      textOutput("wind_speed"),
                      background = "navy"
                    ),
                    
                    box(
                      width = 4,
                      style = "font-size:34px; text-align: center; font-family: 'Poppins', sans-serif;",
                      title = div(tags$i(class = "fas fa-globe-americas box-icon"), "Air Pressure"),
                      textOutput("air_pressure"),
                      background = "maroon"
                    )
                  ),
                  
                  # Phần bản đồ bên dưới
                  tags$div(
                    class = "map-container",
                    style = "margin-top: 40px; width: 100%; display: flex; justify-content: center;",
                    box(
                      width = 10,
                      leafletOutput("map")
                    )
                  )
                )
              )
            )
    ),
    tabItem(
      tabName = "forecast",
      tags$div(
        style = "display: flex; align-items: center;font-size:40px; text-align: center; font-family: 'Poppins', sans-serif;color:white",
        tags$i(class = "fas fa-map-marker-alt custom-icon-fc"),
        tags$div(textOutput("location_")),
      ),
      # Add forecast content here
      
      box(width = 13,
        radioButtons(
          inputId = "feature",
          label = tags$span("Choose options:", style = "font-size: 24px; font-weight: bold;"),
          choices = c(
            "Temperature" = "temp",
            "Feels Like" = "feels_like",
            "Min Temp" = "temp_min",
            "Max Temp" = "temp_max",
            "Pressure" = "pressure",
            "Sea Level" = "sea_level",
            "Ground Level" = "grnd_level",
            "Humidity" = "humidity",
            "Wind Speed" = "speed",
            "Wind Degree" = "deg",
            "Wind Gust" = "gust"
          ),
          selected = "temp",
          inline = TRUE
        ),
        style = "text-align: center; font-size: 22px; font-weight: bold;",
        class = "box-fc"
      ),
      box(plotlyOutput("line_chart"),class = "chart", width="100"),
    )
  )
  )
)

get_weather_info <- function(lat, lon) {
  api_key <- "35aa26b6f8b70e81d64047814f72a78a"
  API_call <-
    "https://api.openweathermap.org/data/2.5/weather?lat=%s&lon=%s&appid=%s"
  complete_url <- sprintf(API_call, lat, lon, api_key)
  json <- fromJSON(complete_url)
  
  location <- json$name
  temp <- json$main$temp - 273.2
  feels_like <- json$main$feels_like - 273.2
  humidity <- json$main$humidity
  weather_condition <- json$weather$description
  visibility <- json$visibility/1000
  wind_speed <- json$wind$speed
  air_pressure <- json$main$pressure
  weather_info <- list(
    Location = location,
    Temperature = temp,
    Feels_like = feels_like,
    Humidity = humidity,
    WeatherCondition = weather_condition,
    Visibility = visibility,
    Wind_speed = wind_speed,
    Air_pressure = air_pressure
  )
  return(weather_info)
}
get_forecast <- function(lat, lon) {
  api_key <- "35aa26b6f8b70e81d64047814f72a78a"
  # base_url variable to store url
  API_call = "https://api.openweathermap.org/data/2.5/forecast?lat=%s&lon=%s&appid=%s"
  
  # Construct complete_url variable to store full url address
  complete_url = sprintf(API_call, lat, lon, api_key)
  #print(complete_url)
  json <- fromJSON(complete_url)
  df <- data.frame(
    Time = json$list$dt_txt,
    Location = json$city$name,
    feels_like = json$list$main$feels_like - 273.2,
    temp_min = json$list$main$temp_min - 273.2,
    temp_max = json$list$main$temp_max - 273.2,
    pressure = json$list$main$pressure,
    sea_level = json$list$main$sea_level,
    grnd_level = json$list$main$grnd_level,
    humidity = json$list$main$humidity,
    temp_kf = json$list$main$temp_kf,
    temp = json$list$main$temp - 273.2,
    id = sapply(json$list$weather, function(entry)
      entry$id),
    main = sapply(json$list$weather, function(entry)
      entry$main),
    icon = sapply(json$list$weather, function(entry)
      entry$icon),
    humidity = json$list$main$humidity,
    weather_conditions = sapply(json$list$weather, function(entry)
      entry$description),
    speed = json$list$wind$speed,
    deg = json$list$wind$deg,
    gust = json$list$wind$gust
  )
  
  return (df)
}

server <- function(input, output, session) {
  autoInvalidate <- reactiveTimer(1000) 
  
  output$current_time <- renderText({
    autoInvalidate()  # Cập nhật lại mỗi giây
    format(Sys.time(), "%Y-%m-%d %H:%M:%S")  # Hiển thị ngày & giờ
  })
  
  # Set default coordinates
  default_lat <- 21.0277644
  default_lon <- 105.8341598
  
  # Initial call to get weather information for the default location
  weather_info <- get_weather_info(default_lat, default_lon)
  
  # Display weather information for the default location
  output$location <- renderText({
    paste(weather_info$Location)
  })
  
  output$humidity <- renderText({
    paste(weather_info$Humidity, "%")
  })
  
  output$temperature <- renderText({
    paste(weather_info$Temperature, "°C")
  })
  
  output$feels_like <- renderText({
    paste(weather_info$Feels_like, "°C")
  })
  
  output$weather_condition <- renderText({
    paste(weather_info$WeatherCondition)
  })
  
  output$visibility <- renderText({
    paste(weather_info$Visibility,"Km")
  })
  
  output$wind_speed <- renderText({
    paste(weather_info$Wind_speed, "Km/h")
  })
  output$air_pressure <- renderText({
    paste(weather_info$Air_pressure)
  })
  
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = default_lon, lat = default_lat, zoom = 10)
  })
  
  click <- NULL
  observeEvent(input$map_click, {
    click <<- input$map_click
    weather_info <<- get_weather_info(click$lat, click$lng)
    # Update weather information when a new location is selected
    output$location <- renderText({
      paste(weather_info$Location)
    })
    output$humidity <- renderText({
      paste(weather_info$Humidity, "%")
    })
    output$temperature <- renderText({
      paste(weather_info$Temperature, "°C")
    })
    output$feels_like <- renderText({
      paste(weather_info$Feels_like, "°C")
    })
    output$weather_condition <- renderText({
      paste(weather_info$WeatherCondition)
    })
    output$visibility <- renderText({
      paste(weather_info$Visibility)
    })
    output$wind_speed <- renderText({
      paste(weather_info$Wind_speed)
    })
  })
  
  observeEvent(input$feature, {
    # display location
    output$location_ <- renderText({
      paste('Location: ', weather_info$Location)
    })
    # set default
    default_lon = 105.8341598
    default_lat = 21.0277644
    data <- get_forecast(default_lat, default_lon)
    output$line_chart <- renderPlotly({
      # Create a line chart using plot_ly
      feature_data <- data[, c("Time", input$feature)]
      # Create a line chart using plot_ly
      plot_ly(data = feature_data, x = ~Time, y = ~.data[[input$feature]], type = 'scatter', mode = 'lines+markers', name = input$feature) %>%
        layout(
          title = "Sample Line Chart",
          xaxis = list(title = "Time"),
          yaxis = list(title = input$feature)
        ) %>%
        add_trace(
          line = list(color = "green"),  # Set the line color to red
          marker = list(color = "red"),  # Set the marker color to black
          showlegend = FALSE  # Hide the legend for this trace
        )
    })
    
    # plot the forecast
    if (!is.null(click)) {
      data <- get_forecast(clicklat,clicklat, clicklng)
      #dat <- data.frame(df[input$feature])
      #names(dat) <- c(input$feature)
      #row.names(dat) <- df$Time
      #renderLineChart(
      #  div_id = "test", 
      #  data = dat
      #)
      output$line_chart <- renderPlotly({
        # Create a line chart using plot_ly
        feature_data <- data[, c("Time", input$feature)]
        # Create a line chart using plot_ly
        plot_ly(data = feature_data, x = ~Time, y = ~.data[[input$feature]], type = 'scatter', mode = 'lines+markers', name = input$feature) %>%
          layout(
            title = "Sample Line Chart",
            xaxis = list(title = "Time"),
            yaxis = list(title = input$feature)
          ) %>%
          add_trace(
            line = list(color = "red"),  # Set the line color to red and hide the legend entry
            marker = list(color = "black"),
            showlegend = FALSE  # Hide the legend for this trace
          )
      })
    }
  })
}

shinyApp(ui, server)
