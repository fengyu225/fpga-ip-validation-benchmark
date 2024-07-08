import re
import sys

import matplotlib.pyplot as plt
import pandas as pd

# Set pandas display options to show all rows and columns
pd.set_option('display.max_rows', None)
pd.set_option('display.max_columns', None)
pd.set_option('display.width', None)
pd.set_option('display.max_colwidth', None)

def extract_metrics(log_content):
    metrics = []
    stage_pattern = re.compile(
        r'(\w.*\s): Time \(s\): cpu = (\d+:\d+:\d+) ; elapsed = (\d+:\d+:\d+) . Memory \(MB\): peak = ([\d.]+) ; gain = [\d.]+ ; free physical = [\d.]+ ; free virtual = [\d.]+')

    for match in stage_pattern.findall(log_content):
        stage, cpu_time, elapsed_time, peak_memory = match
        metrics.append({
            'Stage': stage.strip(),
            'CPU Time': cpu_time,
            'Elapsed Time': elapsed_time,
            'Peak Memory (MB)': float(peak_memory)
        })

    return metrics

def aggregate_metrics(metrics):
    total_elapsed_time = pd.to_timedelta('0:00:00')
    peak_memory = 0

    for metric in metrics:
        total_elapsed_time += pd.to_timedelta(metric['Elapsed Time'])
        if metric['Peak Memory (MB)'] > peak_memory:
            peak_memory = metric['Peak Memory (MB)']

    return total_elapsed_time, peak_memory

def visualize_comparison(metrics_outside, metrics_inside):
    # Convert the metrics to DataFrames
    metrics_df_outside = pd.DataFrame(metrics_outside)
    metrics_df_inside = pd.DataFrame(metrics_inside)

    # Convert the elapsed time to seconds for visualization
    metrics_df_outside['Elapsed Time (s)'] = pd.to_timedelta(metrics_df_outside['Elapsed Time']).dt.total_seconds()
    metrics_df_inside['Elapsed Time (s)'] = pd.to_timedelta(metrics_df_inside['Elapsed Time']).dt.total_seconds()

    # Plot detailed metrics for each stage
    fig, axs = plt.subplots(2, 1, figsize=(12, 10), sharex=True)

    # Plot for outside TEE
    axs[0].bar(metrics_df_outside['Stage'], metrics_df_outside['Elapsed Time (s)'], color='orange', label='Outside TEE')
    axs[0].set_title('Elapsed Time for Each Stage (Outside TEE)')
    axs[0].set_ylabel('Elapsed Time (s)')
    axs[0].tick_params(axis='x', rotation=90)

    # Plot for inside TEE
    axs[1].bar(metrics_df_inside['Stage'], metrics_df_inside['Elapsed Time (s)'], color='blue', label='Inside TEE')
    axs[1].set_title('Elapsed Time for Each Stage (Inside TEE)')
    axs[1].set_ylabel('Elapsed Time (s)')
    axs[1].tick_params(axis='x', rotation=90)

    plt.tight_layout()
    plt.show()

    return metrics_df_outside, metrics_df_inside

def main(log_outside_path, log_inside_path):
    # Read log files
    with open(log_outside_path, 'r') as file:
        log_outside_content = file.read()

    with open(log_inside_path, 'r') as file:
        log_inside_content = file.read()

    # Extract metrics
    metrics_outside = extract_metrics(log_outside_content)
    metrics_inside = extract_metrics(log_inside_content)

    # Aggregate metrics
    total_elapsed_time_outside, peak_memory_outside = aggregate_metrics(metrics_outside)
    total_elapsed_time_inside, peak_memory_inside = aggregate_metrics(metrics_inside)

    # Create a summary DataFrame
    summary_df = pd.DataFrame({
        "Environment": ["Outside TEE", "Inside TEE"],
        "Total Elapsed Time": [str(total_elapsed_time_outside), str(total_elapsed_time_inside)],
        "Peak Memory (MB)": [peak_memory_outside, peak_memory_inside]
    })

    # Save the summary to a CSV file
    summary_df.to_csv('bitstream_generation_summary.csv', index=False)

    # Visualize the comparison
    metrics_df_outside, metrics_df_inside = visualize_comparison(metrics_outside, metrics_inside)

    # Display the summary
    print("Summary:")
    print(summary_df.to_string(index=False))

    # Display detailed metrics for each stage
    print("\nMetrics Outside TEE:")
    print(metrics_df_outside.to_string(index=False))
    print("\nMetrics Inside TEE:")
    print(metrics_df_inside.to_string(index=False))

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python script.py <log_outside_path> <log_inside_path>")
        sys.exit(1)

    log_outside_path = sys.argv[1]
    log_inside_path = sys.argv[2]
    main(log_outside_path, log_inside_path)