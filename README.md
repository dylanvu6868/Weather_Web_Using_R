# Weather Web Using R (Shiny)

## Overview
This project, **Weather Web Using R**, is a weather forecasting application built with **Shiny** in R. It provides real-time weather updates and a **7-day forecast** for different locations worldwide. The app features an interactive **Leaflet map** for location selection and data visualizations using **ggplot2** and **Plotly**.

## Features
✅ **Live Weather Data:** Retrieves real-time weather conditions from an API.  
✅ **7-Day Weather Forecast:** Displays upcoming weather trends.  
✅ **Interactive Leaflet Map:** Allows users to select locations visually.  
✅ **Data Visualization:** Uses **ggplot2** and **Plotly** for graphical representation.  
✅ **User-Friendly UI:** Implemented with **Shiny Dashboard** for better usability.  
✅ **Weather Alerts:** Provides warnings for extreme conditions.  

## Installation
### **Prerequisites**
Ensure you have **R** and **RStudio** installed. Also, install the required R packages:
```r
install.packages(c("shiny", "shinyMatrix", "tidyverse","jsonlite", "leaflet", "ggplot2", "plotly", "dplyr", "shinydashboard"))
```

### **Clone the Repository**
```sh
git clone https://github.com/dylanvu6868/Weather_Web_Using_R.git
cd Weather_Web_Using_R
```

### **Run the App**
```r
library(shiny)
library(leaflet)
library(jsonlite)
library(ggplot2)
library(tidyverse)
library(shinydashboard)
library(dplyr)
library(shinyMatrix)
library(plotly)

runApp("app.R")
```

## Technology Stack
- **Backend:** R (Shiny, `httr`, `jsonlite` for API integration)
- **Frontend:** Shiny UI, `shinydashboard`
- **Mapping:** `leaflet` for interactive maps
- **Data Processing & Visualization:** `tidyverse`, `ggplot2`, `plotly`

## Future Enhancements
- ✅ Save favorite locations for quick access
- ✅ Historical weather trend analysis
- ✅ Machine learning-based weather prediction

## Contribution
Feel free to fork this repository, suggest improvements, and submit pull requests.

## License
This project is licensed under the MIT License.

---
🌦️ **Website Stay informed with real-time weather updates!** 🚀
https://dataexplorationdylan.shinyapps.io/Mini_Project_Weather_App_VHD_DSR301m/

