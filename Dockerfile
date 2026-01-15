# Use official Python base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# --- NETFREE CERT INTSALL ---
ADD https://netfree.link/dl/unix-ca2.sh /home/netfree-unix-ca.sh 
RUN cat  /home/netfree-unix-ca.sh | sh
ENV NODE_EXTRA_CA_CERTS=/etc/ca-bundle.crt
ENV REQUESTS_CA_BUNDLE=/etc/ca-bundle.crt
ENV SSL_CERT_FILE=/etc/ca-bundle.crt
# --- END NETFREE CERT INTSALL ---

# Copy requirements (we have only Flask)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY app.py .

# Expose port 5000
EXPOSE 5000

# Run the app
CMD ["python", "app.py"]
