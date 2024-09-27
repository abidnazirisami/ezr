output=mnaziri_hw3

# Filter data into low and high dimensionality
echo "----------------- Filtering data -----------------"
python3.13 -B filter_data.py ../data/optimize/[chmp]*/*.csv > tmp
grep -e "high" -e "dim" -e "----" tmp > high_dim_datasets.txt
grep -e "low" -e "dim" -e "----" tmp > low_dim_datasets.txt
rm tmp

# Create and run script
echo "----------------- Running experiments -----------------"
make Act=${output} acts

# Summarize results
process_csv_files() {
  local prefix="$1"
  mkdir -p ~/tmp/${output}/${prefix}
  file=${prefix}_dim_datasets.txt
  
  if [[ ! -f "$file" ]]; then
    echo "File not found: $file"
    return 1
  fi
  
  while IFS= read -r line; do
    if [[ "$line" == *".csv"* ]]; then
      base_filename=$(basename "$line")
      cp ~/tmp/${output}/$base_filename ~/tmp/${output}/${prefix}/$base_filename
    fi
  done < "$file"
}

process_csv_files low
process_csv_files high

cd .. ; rq_script=${PWD}/etc/rq.sh

echo "----------------- All results -----------------"
cd ~/tmp/${output} ; bash ${rq_script} | tee results_all.txt

echo "----------------- Low dimensionality results -----------------"
cd ~/tmp/${output}/low ; bash ${rq_script} | tee results_low.txt

echo "----------------- High dimensionality results -----------------"
cd ~/tmp/${output}/high ; bash ${rq_script} | tee results_high.txt