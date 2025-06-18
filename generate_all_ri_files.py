import os
import subprocess
import sys

def run_interpolation(metal, step_size, wl_start=300, wl_end=800):
    """
    Generate interpolated RI file for a specific metal and step size
    """
    input_file = f"{metal}_ri_master.txt"
    output_file = f"{metal}_ri_{step_size}nm.txt"
    
    # Check if input file exists
    if not os.path.exists(input_file):
        print(f"ERROR: Input file {input_file} not found!")
        return False
    
    # Run the interpolation script
    cmd = [
        "python3", "generate_ri_file.py",
        input_file, output_file,
        "-s", str(wl_start),
        "-e", str(wl_end),
        "-t", str(step_size)
    ]
    
    print(f"Generating {output_file}...")
    try:
        result = subprocess.run(cmd, capture_output=True, text=True)
        if result.returncode == 0:
            print(f"✓ Successfully generated {output_file}")
            return True
        else:
            print(f"✗ Error generating {output_file}")
            print(f"Error: {result.stderr}")
            return False
    except Exception as e:
        print(f"✗ Exception while generating {output_file}: {e}")
        return False

def main():
    # Configuration
    metals = ["silver", "gold", "copper", "palladium", "platinum"]
    step_sizes = [0.5, 1.0, 2.5]
    wl_start = 300  # Starting wavelength
    wl_end = 800    # Ending wavelength
    
    print("="*60)
    print("Batch RI File Generation Script")
    print("="*60)
    print(f"Metals: {', '.join(metals)}")
    print(f"Step sizes: {step_sizes} nm")
    print(f"Wavelength range: {wl_start} - {wl_end} nm")
    print("="*60)
    
    # Check if generate_ri_file.py exists
    if not os.path.exists("generate_ri_file.py"):
        print("ERROR: generate_ri_file.py not found in current directory!")
        sys.exit(1)
    
    # Track statistics
    total_files = len(metals) * len(step_sizes)
    successful = 0
    failed = 0
    
    # Generate all combinations
    for metal in metals:
        print(f"\nProcessing {metal.upper()}:")
        print("-" * 40)
        
        for step_size in step_sizes:
            success = run_interpolation(metal, step_size, wl_start, wl_end)
            if success:
                successful += 1
            else:
                failed += 1
    
    # Summary
    print("\n" + "="*60)
    print("GENERATION SUMMARY")
    print("="*60)
    print(f"Total files to generate: {total_files}")
    print(f"Successfully generated: {successful}")
    print(f"Failed: {failed}")
    
    if failed == 0:
        print("🎉 All files generated successfully!")
    else:
        print(f"⚠️  {failed} files failed to generate. Check error messages above.")
    
    print("\nGenerated files:")
    for metal in metals:
        for step_size in step_sizes:
            filename = f"{metal}_ri_{step_size}nm.txt"
            if os.path.exists(filename):
                file_size = os.path.getsize(filename)
                print(f"  ✓ {filename} ({file_size} bytes)")
            else:
                print(f"  ✗ {filename} (missing)")

if __name__ == "__main__":
    main()