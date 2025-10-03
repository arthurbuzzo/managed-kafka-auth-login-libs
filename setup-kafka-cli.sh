#!/bin/bash
set -e

BASE_DIR=$HOME/kafka
JAVA_DIR=$HOME/java17

echo "📦 Criando diretórios..."
mkdir -p $BASE_DIR

# ---------------------------
# 1. Instalar Java (OpenJDK 17)
# ---------------------------
if [ ! -d "$JAVA_DIR" ]; then
  echo "⬇️ Baixando e instalando OpenJDK 17..."
  curl -L -o $HOME/openjdk17.tar.gz \
    https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.14+7/OpenJDK17U-jdk_x64_linux_hotspot_17.0.14_7.tar.gz

  tar -xzf $HOME/openjdk17.tar.gz -C $HOME
  mv $HOME/jdk-17* $JAVA_DIR
else
  echo "☑️ Java já instalado em $JAVA_DIR"
fi

export JAVA_HOME=$JAVA_DIR
export PATH=$JAVA_HOME/bin:$PATH

echo "✅ Java configurado: $(java -version 2>&1 | head -n 1)"

# ---------------------------
# 2. Instalar Kafka CLI
# ---------------------------
if [ ! -d "$BASE_DIR/bin" ]; then
  echo "⬇️ Baixando e instalando Kafka..."
  curl -L -o $HOME/kafka.tgz \
    https://downloads.apache.org/kafka/3.8.0/kafka_2.13-3.8.0.tgz

  tar -xzf $HOME/kafka.tgz -C $HOME
  mv $HOME/kafka_2.13-3.8.0 $BASE_DIR
else
  echo "☑️ Kafka já instalado em $BASE_DIR"
fi

echo "✅ Kafka configurado: $($BASE_DIR/bin/kafka-topics.sh --version)"

# ---------------------------
# 3. Baixar libs de autenticação
# ---------------------------
echo "⬇️ Baixando pacotes de autenticação..."
curl -L -o $BASE_DIR/managed-kafka-auth-login-handler-1.0.6-full.tar \
  https://github.com/arthurbuzzo/managed-kafka-auth-login-libs/raw/main/managed-kafka-auth-login-handler-1.0.6-full.tar

echo "📂 Extraindo libs para $BASE_DIR/libs..."
tar -xf $BASE_DIR/managed-kafka-auth-login-handler-1.0.6-full.tar -C $BASE_DIR/libs

# ---------------------------
# 4. Baixar client.properties
# ---------------------------
echo "⬇️ Baixando client.properties..."
curl -L -o $BASE_DIR/client.properties \
  https://github.com/arthurbuzzo/managed-kafka-auth-login-libs/raw/main/client.properties

# ---------------------------
# 5. Final
# ---------------------------
echo "✅ Setup concluído!"
echo ""
echo "Use os comandos Kafka com:"
echo "  --command-config $BASE_DIR/client.properties"
