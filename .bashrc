export http_proxy=wp-ewa-proxy.web.boeing.com:31060
export https_proxy=wp-ewa-proxy.web.boeing.com:31060

export PATH="$(realpath $(dirname $0))/bin:$PATH"

export LD_LIBRARY_PATH="$(realpath $(dirname $0))/lib64:$LD_LIBRARY_PATH"
