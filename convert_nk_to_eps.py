import numpy as np
import argparse

"""
USAGE:
python convert_nk_to_eps.py your_silver_file.txt silver_eps.txt

"""

def convert_nk_to_eps(input_file, output_file):
    """
    Convert (n,k) refractive index data to dielectric function (eps1, eps2)
    """
    wavelengths = []
    eps1_values = []
    eps2_values = []
    
    with open(input_file, 'r') as f:
        for line in f:
            line = line.strip()
            if line.startswith('#') or not line:
                continue
            parts = line.split()
            if len(parts) >= 3:
                wl = float(parts[0])
                n = float(parts[1])
                k = float(parts[2])
                
                # Convert (n,k) to dielectric function
                eps1 = n**2 - k**2      # Real part of dielectric function
                eps2 = 2 * n * k        # Imaginary part of dielectric function
                
                wavelengths.append(wl)
                eps1_values.append(eps1)
                eps2_values.append(eps2)
    
    # Write output file
    with open(output_file, 'w') as f:
        f.write("# Dielectric function data converted from (n,k)\n")
        f.write(f"# Generated from: {input_file}\n")
        f.write("# Wavelength(nm)  eps1_real  eps2_imag\n")
        
        for i, wl in enumerate(wavelengths):
            f.write(f"{wl:.1f}  {eps1_values[i]:.6f}  {eps2_values[i]:.6f}\n")
    
    print(f"Converted {len(wavelengths)} data points from (n,k) to dielectric function")
    print(f"Output written to: {output_file}")
    
    # Show some sample conversions for verification
    print("\nSample conversions:")
    for i in range(0, min(5, len(wavelengths))):
        wl = wavelengths[i]
        # Recalculate for display
        with open(input_file, 'r') as f:
            for line in f:
                if line.strip().startswith(str(wl)):
                    parts = line.split()
                    n, k = float(parts[1]), float(parts[2])
                    print(f"{wl:.1f} nm: (n={n:.3f}, k={k:.3f}) → (ε₁={eps1_values[i]:.3f}, ε₂={eps2_values[i]:.3f})")
                    break

def main():
    parser = argparse.ArgumentParser(description="Convert (n,k) refractive index data to dielectric function")
    parser.add_argument("input_file", help="Input file with (n,k) data")
    parser.add_argument("output_file", help="Output file for dielectric function data")
    
    args = parser.parse_args()
    convert_nk_to_eps(args.input_file, args.output_file)

if __name__ == "__main__":
    main()