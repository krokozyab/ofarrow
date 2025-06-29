# Arrow Flight SQL Server for Oracle Fusion

A read-only Arrow Flight SQL server for Oracle Fusion, spun off from the [ofjdbc](https://github.com/krokozyab/ofjdbc) project to complement the ecosystem.

While the root [ofjdbc project](https://github.com/krokozyab/ofjdbc) is well-suited for exploratory work within DBeaver IDE, this project provides a complete ecosystem by:

- **Easy Python scripting** via Arrow Flight clients for ETL tools like Apache Airflow, Prefect, Dagster
- **HTTP endpoint** for loading CSV data using curl, wget, etc. - perfect for shell scripts and automation
- **High-performance data transfer** using Apache Arrow's columnar format
- **Streaming capabilities** for large datasets with automatic pagination

## Arrow Flight SQL Advantages

- **Columnar Data Format**: Apache Arrow's memory layout is optimized for analytical workloads
- **Language Agnostic**: Native clients available for Python, R, Go, Rust, JavaScript, and more
- **High Throughput**: Efficient binary protocol designed for large-scale data transfer (although bottlenecked by underlying Oracle Fusion reporting architecture)
- **Streaming**: Handle datasets larger than memory with automatic batching
- **Standards Compliant**: Implements Flight SQL specification for broad compatibility

---

## 📄 Table of Contents

- [🚀 Features](#-features)
- [🛠 Prerequisites](#-prerequisites)
- [📝 Installation](#-installation)
- [⚙️ Configuration](#-configuration)
- [❗ Limitations](#-Limitations)
- [⚠️ Important Disclaimer](#-important-disclaimer)
- [📝 TODO](#-todo)
- [📚 Examples](#-examples)
- [🔗 Other ](#-other)
- [📫 Contact](#-contact)

---

## 🚀 Features

### Flight SQL Server
- **High-Performance Streaming**: Apache Arrow Flight SQL protocol for efficient data transfer
- **Automatic Pagination**: Handles large Oracle Fusion datasets with built-in pagination
- **Multi-Client Support**: Connect from Python, R, or any Flight SQL client
- **Memory Efficient**: Columnar data format optimized for analytical workloads

### HTTP API
- **Simple CSV Export**: Direct HTTP endpoint for curl/wget data extraction
- **No Dependencies**: Works with any HTTP client or scripting language
- **Command Line Friendly**: Perfect for shell scripts and automation

### Oracle Fusion Integration
- **WSDL-Based**: Connects to Oracle Fusion via standard WSDL reporting services
- **Credential Security**: Your credentials stay under your control
- **Read-Only Access**: Safe for production environments
- **Standard SQL**: Use familiar SQL syntax for Oracle Fusion data

---

## 🛠 Prerequisites

Before using this server, ensure you have the following:

- **Oracle Fusion Access:** Valid credentials with access to Oracle Fusion reporting (via WSDL).
- **JDK/JRE:** A Java 17 (or later) runtime installed on your machine.

---

## 📝 Installation

1. **Download the Server:**
   Download the latest version from the releases section (file orfujdbc-1.0-SNAPSHOT.jar).

   [![GitHub Downloads](https://img.shields.io/github/downloads/krokozyab/ofarrow/total?style=for-the-badge&logo=github)](https://github.com/krokozyab/ofarrow/releases)

3. Create report in OTBI In you fusion instance, un-archive 
DM_ARB.xdm.catalog and RP_ARB.xdo.catalog from [OTBI report](https://github.com/krokozyab/ofjdbc/tree/master/otbireport)  into /Shared Folders/Custom/Financials folder (that can be different if you will). If you already use my OFJDBC driver you may skip this step.

2. **Set Environment Variables:**
   ```bash
   export OFJDBC_URL="jdbc:wsdl://<your-server>.oraclecloud.com/xmlpserver/services/ExternalReportWSSService?WSDL:/Custom/Financials/RP_ARB.xdo"
   export OFJDBC_USER="your_username"
   export OFJDBC_PASS="your_password"
   export JAVA_TOOL_OPTIONS="--add-opens=java.base/java.nio=org.apache.arrow.memory.core,ALL-UNNAMED"
   ```
   
3. **Run the Server:**
   ```bash
   java -jar oflight-1.0-SNAPSHOT.jar
   ```
**Windows**
```
# Flight SQL Server Startup Script - Windows PowerShell dots important . .\start-windows.ps1

Write-Host "Starting Flight SQL Server for Oracle Fusion..." -ForegroundColor Green

# Set environment variables
$env:OFJDBC_URL = "jdbc:wsdl://<your-server>.oraclecloud.com/xmlpserver/services/ExternalReportWSSService?WSDL:/Custom/Financials/RP_ARB.xdo"
$env:OFJDBC_USER = "your_username"
$env:OFJDBC_PASS = "your_password"
$env:FLIGHT_PORT = "32010"
$env:JAVA_TOOL_OPTIONS = "--add-opens=java.base/java.nio=org.apache.arrow.memory.core,ALL-UNNAMED"

# Run the server
java -jar oflight-1.0-SNAPSHOT.jar
```
**MacOS**
```
#!/bin/bash
# Flight SQL Server Startup Script - macOS

echo "🚀 Starting Flight SQL Server for Oracle Fusion..."

# Set environment variables
export OFJDBC_URL="jdbc:wsdl://<your-server>.oraclecloud.com/xmlpserver/services/ExternalReportWSSService?WSDL:/Custom/Financials/RP_ARB.xdo"
export OFJDBC_USER="your_username"
export OFJDBC_PASS="your_password"
export FLIGHT_PORT="32010"
export JAVA_TOOL_OPTIONS="--add-opens=java.base/java.nio=org.apache.arrow.memory.core,ALL-UNNAMED"

# Run the server
java -jar oflight-1.0-SNAPSHOT.jar
```
**Linux**
```
#!/bin/bash
# Flight SQL Server Startup Script - Linux

echo "🚀 Starting Flight SQL Server for Oracle Fusion..."

# Set environment variables
export OFJDBC_URL="jdbc:wsdl://<your-server>.oraclecloud.com/xmlpserver/services/ExternalReportWSSService?WSDL:/Custom/Financials/RP_ARB.xdo"
export OFJDBC_USER="your_username"
export OFJDBC_PASS="your_password"
export FLIGHT_PORT="32010"
export JAVA_TOOL_OPTIONS="--add-opens=java.base/java.nio=org.apache.arrow.memory.core,ALL-UNNAMED"

# Run the server
java -jar oflight-1.0-SNAPSHOT.jar
```
## ⚙️ Usage

### Python Client
```python
import pyarrow.flight as fl

client = fl.connect("grpc://localhost:32010")
sql = "SELECT * FROM fnd_currencies_tl WHERE rownum <= 10"
table = client.execute(sql).read_all()
print(table.to_pandas())
```

### HTTP API
```bash
# Get data as CSV
curl -o data.csv 'http://localhost:8081/query?sql=SELECT * FROM fnd_currencies_tl WHERE rownum <= 100'

# Using wget
wget -O data.csv 'http://localhost:8081/query?sql=SELECT code_combination_id FROM gl_code_combinations WHERE rownum <= 50'
```

## ❗ Limitations

- Read-only access to Oracle Fusion data
- Requires Oracle Fusion WSDL reporting setup
- Limited to SQL SELECT statements
- Pagination handled automatically for large datasets
- Some limitations are inherent to the underlying Oracle Fusion reporting architecture.
  For further insights on some of these challenges, see this article on using synchronous BIP for data extraction.
  https://www.ateam-oracle.com/post/using-synchronous-bip-for-extracting-data-dont


## ⚠️ Important Disclaimer

Consult with your organization's security team before deployment. Ensure compliance with your security policies and standards.

### The project in its very early experimentation stage.

## 📝 TODO

- Enhanced error handling and logging
- Additional metadata support
- Performance optimizations
- Extended authentication mechanisms
- Excel integration

## 📚 Examples

- **High level ABCD driver with polars:** [High level ABCD driver with polars](https://gist.github.com/krokozyab/7cf1df6c5c7b6b1ea1b85fe150481156)
- **Low level driver with pandas:** [Low level driver with pandas](https://gist.github.com/krokozyab/87485ac203afb2b357cb369dbcd4d1d8)
- **Save vendors to parquet file:** [Save vendors to parquet file](https://gist.github.com/krokozyab/ef1b7999b518fb96897adeffb3982cfe)
- **HTTP Linux Example:** [HTTP Linux Example](https://gist.github.com/krokozyab/2829b3f9d28530c45a1361cb519b94d6)
- **HTTP MacOS Example:** [HTTP MAcOS Example](https://gist.github.com/krokozyab/c13b545abdc179e12205306ab9c4cb24)
- **HTTP Windows Example:** [HTTP Windows Example](https://gist.github.com/krokozyab/312668fdebe991b38cc912d2f73fb23c)

## 🔗 Other

- **Root Project:** [ofjdbc - Oracle Fusion JDBC Driver](https://github.com/krokozyab/ofjdbc)

## 📫 Contact

For questions or issues, reach out via GitHub Issues or [sergey.rudenko.ba@gmail.com](mailto:sergey.rudenko.ba@gmail.com).
