echo "Starting server"
python server.py &
sleep 3  # Sleep for 3s to give the server enough time to start

# Download data
mkdir ./data
python -c "from sklearn.datasets import load_iris; load_iris(as_frame=True)['data'].to_csv('./data/client.csv')"

for i in `seq 0 1`; do
    echo "Starting client $i"
    python client.py &
done

# This will allow you to use CTRL+C to stop all background processes
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM
# Wait for all background processes to complete
wait
