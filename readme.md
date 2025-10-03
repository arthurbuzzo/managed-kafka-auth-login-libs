# Kafka CLI - GCP Managed Kafka

Guia de configuração e uso do Kafka CLI para conectar nos clusters **Managed Kafka (GCP)**.

---

## 🚀 Setup inicial

Baixe e execute o script de setup:

```bash
curl -L -o setup-kafka-cli.sh \
  https://github.com/arthurbuzzo/managed-kafka-auth-login-libs/raw/main/setup-kafka-cli.sh

chmod +x setup-kafka-cli.sh
./setup-kafka-cli.sh
````

# Autenticar usuário na conta GCP
```bash
gcloud auth login
````

# Definir o projeto (ajuste conforme ambiente)
```bash
gcloud config set project <PROJECT_ID>
````

# Autenticação padrão de aplicações (necessária para o Kafka CLI)
```bash
gcloud auth application-default login
````
# Comandos do Kafka Cli

```bash
~/kafka/bin/kafka-topics.sh \
  --bootstrap-server <BOOTSTRAP_SERVER> \
  --command-config ~/kafka/client.properties \
  --list

~/kafka/bin/kafka-console-producer.sh \
  --bootstrap-server <BOOTSTRAP_SERVER> \
  --producer.config ~/kafka/client.properties \
  --topic <TOPICO>

~/kafka/bin/kafka-console-consumer.sh \
  --bootstrap-server <BOOTSTRAP_SERVER> \
  --consumer.config ~/kafka/client.properties \
  --topic <TOPICO> \
  --from-beginning
````
