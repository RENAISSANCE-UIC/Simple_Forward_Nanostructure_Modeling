import numpy as np
import argparse
import sys

"""
Usage:
python interpolate_ri.py input_file.txt output_file.txt -s 400 -e 800 -t 1.0
"""

def interpolate_ri_data(input_file, output_file, wl_start, wl_end, wl_step):
    """
    Read sparse RI data and interpolate to create dense wavelength grid
    """
    # Read the input data
    wavelengths = []
    n_real = []
    n_imag = []
    
    with open(input_file, 'r') as f:
        for line in f:
            line = line.strip()
            if line.startswith('#') or not line:
                continue
            parts = line.split()
            if len(parts) >= 3:
                wavelengths.append(float(parts[0]))
                n_real.append(float(parts[1]))
                n_imag.append(float(parts[2]))
    
    # Convert to numpy arrays
    wl_data = np.array(wavelengths)
    n_real_data = np.array(n_real)
    n_imag_data = np.array(n_imag)
    
    # Create new wavelength grid
    new_wavelengths = np.arange(wl_start, wl_end + wl_step, wl_step)
    
    # Interpolate
    new_n_real = np.interp(new_wavelengths, wl_data, n_real_data)
    new_n_imag = np.interp(new_wavelengths, wl_data, n_imag_data)
    
    # Write output file
    with open(output_file, 'w') as f:
        f.write("# Interpolated refractive index data\n")
        f.write(f"# Generated from: {input_file}\n")
        f.write(f"# Wavelength range: {wl_start} - {wl_end} nm (step: {wl_step})\n")
        f.write("# Wavelength(nm)  n_real  n_imag\n")
        
        for i, wl in enumerate(new_wavelengths):
            f.write(f"{wl:.1f}  {new_n_real[i]:.6f}  {new_n_imag[i]:.6f}\n")
    
    print(f"Generated {len(new_wavelengths)} wavelength points from {wl_start} to {wl_end} nm")
    print(f"Output written to: {output_file}")
    
def main():
    parser = argparse.ArgumentParser(description="Interpolate refractive index data")
    parser.add_argument("input_file", help="Input RI file with sparse data")
    parser.add_argument("output_file", help="Output RI file with interpolated data")
    parser.add_argument("-s", "--start", type=float, required=True, help="Starting wavelength")
    parser.add_argument("-e", "--end", type=float, required=True, help="Ending wavelength")
    parser.add_argument("-t", "--step", type=float, required=True, help="Wavelength step size")
    
    args = parser.parse_args()
    
    interpolate_ri_data(args.input_file, args.output_file, args.start, args.end, args.step)

if __name__ == "__main__":
    main()
