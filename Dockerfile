# 1. Usar uma imagem base oficial do Python.
# A imagem "slim" é uma boa prática para manter o tamanho da imagem final menor,
# pois contém apenas o mínimo necessário para executar aplicações Python.
# A versão 3.11 é estável e compatível com o projeto, conforme o readme.md.
FROM python:3.11-slim

# 2. Definir o diretório de trabalho dentro do contêiner.
# Todos os comandos subsequentes serão executados a partir deste diretório.
WORKDIR /app

# 3. Copiar o arquivo de dependências primeiro.
# Isso aproveita o cache de camadas do Docker. Se o requirements.txt não mudar,
# o Docker não reinstalará as dependências em builds futuros, acelerando o processo.
COPY requirements.txt ./

# 4. Instalar as dependências do projeto.
# A flag --no-cache-dir garante que não haverá cache do pip, reduzindo o tamanho da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copiar o restante do código da aplicação para o diretório de trabalho.
COPY . .

# 6. Expor a porta em que a aplicação estará rodando.
EXPOSE 8000

# 7. Comando para executar a aplicação quando o contêiner iniciar.
# Usamos uvicorn para rodar a aplicação FastAPI.
# O host "0.0.0.0" torna a aplicação acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]