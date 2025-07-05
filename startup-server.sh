#!/bin/bash
# Oracle Fusion Flight SQL Server - macOS/Linux Startup Script (Headless)

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Oracle Fusion Flight SQL Server (Headless)${NC}"
echo ""

# Check if Java is installed
if ! command -v java &> /dev/null; then
    echo -e "${RED}❌ Java is not installed or not in PATH${NC}"
    echo -e "${YELLOW}   Please install Java 17 or later${NC}"
    exit 1
fi

# Check if JAR file exists
JAR_FILE="orfujdbc-1.0-SNAPSHOT.jar"
if [ ! -f "$JAR_FILE" ]; then
    echo -e "${RED}❌ JAR file not found: $JAR_FILE${NC}"
    echo -e "${YELLOW}   Please ensure the JAR file is in the same directory as this script${NC}"
    exit 1
fi

# Check for configuration
if [ -z "$OFJDBC_URL" ] || [ -z "$OFJDBC_USER" ] || [ -z "$OFJDBC_PASS" ]; then
    echo -e "${YELLOW}⚠️  Oracle Fusion credentials not found in environment${NC}"
    echo -e "${YELLOW}   Please run: source config.env (after editing it with your credentials)${NC}"
    exit 1
fi

echo -e "${GREEN}🚀 Starting Flight SQL Server...${NC}"

# Start the server
java -cp "$JAR_FILE" my.jdbc.flight.FlightSqlServer