#!/bin/bash
# generate_mpi_jobs.sh

WAVELENGTHS="300.0 350.0 400.0 450.0 500.0"
JOB_COUNTER=1

for wl in $WAVELENGTHS; do
    cat > "adda_mpi_${wl}nm.sh" << 'EOF'
#!/bin/bash
#SBATCH --partition=batch
#SBATCH --job-name=adda_WL_PLACEHOLDER
#SBATCH --nodes=1
#SBATCH --tasks-per-node=24
#SBATCH --time=05:00:00
#SBATCH --output=OUTPUT_WL_PLACEHOLDER_%j.log
#SBATCH --mail-user=weaackerm@uic.edu

module load adda/1.4.0
module load apptainer
module load OpenMPI

cd /home/weackerm/com_irina_chi_link/weackerm/DDA_Input

# Configuration
SHAPE_FILE="ag_fcc_100_stabilized_moderate_25nm.dat"
BASE_OUTPUT_DIR="ag_25nm_mpi_individual"
N_MEDIUM=1.33
WL=WL_PLACEHOLDER

declare -A SILVER_RI
SILVER_RI[300.0]="1.345556 0.985889"
SILVER_RI[302.5]="1.308500 0.911800"
SILVER_RI[305.0]="1.256000 0.824800"
SILVER_RI[307.5]="1.203500 0.737800"
SILVER_RI[310.0]="1.151000 0.650800"
SILVER_RI[312.5]="1.076667 0.578667"
SILVER_RI[315.0]="0.987778 0.516444"
SILVER_RI[317.5]="0.898889 0.454222"
SILVER_RI[320.0]="0.810000 0.392000"
SILVER_RI[322.5]="0.676667 0.483042"
SILVER_RI[325.0]="0.543333 0.574083"
SILVER_RI[327.5]="0.410000 0.665125"
SILVER_RI[330.0]="0.276667 0.756167"
SILVER_RI[332.5]="0.168636 0.843227"
SILVER_RI[335.0]="0.161818 0.914364"
SILVER_RI[337.5]="0.155000 0.985500"
SILVER_RI[340.0]="0.148182 1.056636"
SILVER_RI[342.5]="0.141364 1.127773"
SILVER_RI[345.0]="0.132727 1.192364"
SILVER_RI[347.5]="0.123636 1.255318"
SILVER_RI[350.0]="0.114545 1.318273"
SILVER_RI[352.5]="0.105455 1.381227"
SILVER_RI[355.0]="0.097857 1.436000"
SILVER_RI[357.5]="0.092500 1.478500"
SILVER_RI[360.0]="0.087143 1.521000"
SILVER_RI[362.5]="0.081786 1.563500"
SILVER_RI[365.0]="0.076429 1.606000"
SILVER_RI[367.5]="0.071071 1.648500"
SILVER_RI[370.0]="0.067143 1.686571"
SILVER_RI[372.5]="0.063571 1.723536"
SILVER_RI[375.0]="0.060000 1.760500"
SILVER_RI[377.5]="0.056429 1.797464"
SILVER_RI[380.0]="0.052857 1.834429"
SILVER_RI[382.5]="0.050000 1.870867"
SILVER_RI[385.0]="0.050000 1.905200"
SILVER_RI[387.5]="0.050000 1.939533"
SILVER_RI[390.0]="0.050000 1.973867"
SILVER_RI[392.5]="0.050000 2.008200"
SILVER_RI[395.0]="0.050000 2.042533"
SILVER_RI[397.5]="0.050000 2.076406"
SILVER_RI[400.0]="0.050000 2.108437"
SILVER_RI[402.5]="0.050000 2.140469"
SILVER_RI[405.0]="0.050000 2.172500"
SILVER_RI[407.5]="0.050000 2.204531"
SILVER_RI[410.0]="0.050000 2.236562"
SILVER_RI[412.5]="0.050000 2.268594"
SILVER_RI[415.0]="0.048889 2.295778"
SILVER_RI[417.5]="0.047500 2.321750"
SILVER_RI[420.0]="0.046111 2.347722"
SILVER_RI[422.5]="0.044722 2.373694"
SILVER_RI[425.0]="0.043333 2.399667"
SILVER_RI[427.5]="0.041944 2.425639"
SILVER_RI[430.0]="0.040556 2.451611"
SILVER_RI[432.5]="0.040000 2.476625"
SILVER_RI[435.0]="0.040000 2.501000"
SILVER_RI[437.5]="0.040000 2.525375"
SILVER_RI[440.0]="0.040000 2.549750"
SILVER_RI[442.5]="0.040000 2.574125"
SILVER_RI[445.0]="0.040000 2.598500"
SILVER_RI[447.5]="0.040000 2.622875"
SILVER_RI[450.0]="0.040000 2.647250"
SILVER_RI[452.5]="0.040750 2.672900"
SILVER_RI[455.0]="0.042000 2.699400"
SILVER_RI[457.5]="0.043250 2.725900"
SILVER_RI[460.0]="0.044500 2.752400"
SILVER_RI[462.5]="0.045750 2.778900"
SILVER_RI[465.0]="0.047000 2.805400"
SILVER_RI[467.5]="0.048250 2.831900"
SILVER_RI[470.0]="0.049500 2.858400"
SILVER_RI[472.5]="0.050000 2.882440"
SILVER_RI[475.0]="0.050000 2.904840"
SILVER_RI[477.5]="0.050000 2.927240"
SILVER_RI[480.0]="0.050000 2.949640"
SILVER_RI[482.5]="0.050000 2.972040"
SILVER_RI[485.0]="0.050000 2.994440"
SILVER_RI[487.5]="0.050000 3.016840"
SILVER_RI[490.0]="0.050000 3.039240"
SILVER_RI[492.5]="0.050000 3.061640"
SILVER_RI[495.0]="0.050000 3.084040"
SILVER_RI[497.5]="0.050000 3.106860"
SILVER_RI[500.0]="0.050000 3.129960"

# Safe directory setup
mkdir -p $BASE_OUTPUT_DIR
cd $BASE_OUTPUT_DIR

# Thread-safe shape file copying
(
    flock -x 200
    if [ ! -f "$(basename $SHAPE_FILE)" ]; then
        cp ../$SHAPE_FILE .
    fi
) 200>shape_file.lock

SHAPE_FILENAME=$(basename $SHAPE_FILE)

echo "Processing wavelength: ${WL}nm"

# Get refractive index for this wavelength
ri_values=${SILVER_RI[$WL]}
if [ -z "$ri_values" ]; then
    echo "Error: No refractive index data for ${WL}nm"
    exit 1
fi

# Calculate relative refractive index
n_real_abs=$(echo $ri_values | cut -d' ' -f1)
n_imag_abs=$(echo $ri_values | cut -d' ' -f2)
n_rel_real=$(echo "scale=6; $n_real_abs / $N_MEDIUM" | bc -l)
n_rel_imag=$(echo "scale=6; $n_imag_abs / $N_MEDIUM" | bc -l)

echo "Using silver absolute RI: ${n_real_abs} + ${n_imag_abs}i"
echo "Using relative RI: ${n_rel_real} + ${n_rel_imag}i"

# Define wavelength-specific directory
wl_dir="wl_${WL}nm"

# Run MPI ADDA simulation
echo "Running MPI ADDA simulation..."
mpirun -np 24 apptainer exec /software/EasyBuild/AMD_EPYC_7763_64-Core_Processor/software/adda/1.4.0/adda.sif adda_mpi \
     -shape read $SHAPE_FILENAME \
     -lambda $WL \
     -m $n_rel_real $n_rel_imag \
     -dir $wl_dir

adda_exit_code=$?
echo "ADDA exit code: $adda_exit_code"

# Process results
if [ $adda_exit_code -eq 0 ] && [ -f "${wl_dir}/CrossSec-Y" ]; then
    qext=$(grep "^Qext" "${wl_dir}/CrossSec-Y" | awk -F'=' '{print $2}' | tr -d ' \t')
    qabs=$(grep "^Qabs" "${wl_dir}/CrossSec-Y" | awk -F'=' '{print $2}' | tr -d ' \t')
    qsca=$(grep "^Qsca" "${wl_dir}/CrossSec-Y" | awk -F'=' '{print $2}' | tr -d ' \t')
    
    # Write results to individual file
    echo "$WL $qext $qabs $qsca" > "result_${WL}nm.txt"
    echo "Success: Qext=$qext, Qabs=$qabs, Qsca=$qsca"
else
    echo "Error: ADDA simulation failed or no results file"
    exit 1
fi

echo "Completed wavelength ${WL}nm"
EOF

    # Replace placeholders with actual wavelength
    sed -i "s/WL_PLACEHOLDER/${wl}/g" "adda_mpi_${wl}nm.sh"
    
    chmod +x "adda_mpi_${wl}nm.sh"
    echo "Created job script for ${wl}nm"
    JOB_COUNTER=$((JOB_COUNTER + 1))
done

echo ""
echo "Generated job scripts:"
ls -la adda_mpi_*.sh
echo ""
echo "To submit all jobs:"
echo "for script in adda_mpi_*.sh; do sbatch \$script; done"
