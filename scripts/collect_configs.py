#!/usr/bin/env python3
import os
import datetime

def collect_configs(root_directory, output_file="collected_configs.txt", exclude_dirs=None, exclude_extensions=None):
    """
    Collects and copies the contents of all files in the specified directory and its subdirectories
    into a single text file, with clear separation and headers for each file.
    
    Args:
        root_directory (str): The root directory to start collecting from
        output_file (str): Name of the output file
        exclude_dirs (list): List of directory names to exclude
        exclude_extensions (list): List of file extensions to exclude
    """
    if exclude_dirs is None:
        exclude_dirs = ['.git', '__pycache__', 'node_modules', 'venv']
    
    if exclude_extensions is None:
        exclude_extensions = ['.pyc', '.pyo', '.pyd', '.exe', '.dll', '.so', '.dylib']
    
    # Ensure the directory exists
    if not os.path.exists(root_directory):
        print(f"Error: Directory '{root_directory}' does not exist.")
        return False
    
    with open(output_file, 'w', encoding='utf-8') as outfile:
        # Write header with timestamp
        outfile.write(f"Configuration Collection\n")
        outfile.write(f"Generated on: {datetime.datetime.now()}\n")
        outfile.write(f"Root directory: {os.path.abspath(root_directory)}\n")
        outfile.write("=" * 80 + "\n\n")
        
        # Walk through directory
        for dirpath, dirnames, filenames in os.walk(root_directory):
            # Remove excluded directories
            dirnames[:] = [d for d in dirnames if d not in exclude_dirs]
            
            # Process each file
            for filename in filenames:
                if os.path.splitext(filename)[1] not in exclude_extensions:
                    filepath = os.path.join(dirpath, filename)
                    try:
                        # Write file header
                        relative_path = os.path.relpath(filepath, root_directory)
                        outfile.write(f"File: {relative_path}\n")
                        outfile.write("-" * 80 + "\n")
                        
                        # Write file contents
                        with open(filepath, 'r', encoding='utf-8') as infile:
                            content = infile.read()
                            outfile.write(content)
                        
                        # Add spacing between files
                        outfile.write("\n\n" + "=" * 80 + "\n\n")
                    except (UnicodeDecodeError, PermissionError, IOError) as e:
                        outfile.write(f"Error reading file: {str(e)}\n")
                        outfile.write("\n" + "=" * 80 + "\n\n")
    
    print(f"\nConfiguration collection complete!")
    print(f"Output saved to: {os.path.abspath(output_file)}")
    return True

if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description="Collect configuration files into a single text file")
    parser.add_argument("directory", nargs="?", help="Root directory to collect configurations from")
    parser.add_argument("--output", "-o", default="collected_configs.txt", 
                      help="Output file name (default: collected_configs.txt)")
    parser.add_argument("--exclude-dirs", "-d", nargs="*", 
                      help="Additional directories to exclude")
    parser.add_argument("--exclude-extensions", "-e", nargs="*", 
                      help="Additional file extensions to exclude")
    
    args = parser.parse_args()
    
    # If no directory is provided, prompt for one
    directory = args.directory
    if not directory:
        print("\nWelcome to Config Collector!")
        print("This script will collect all configuration files into a single text file.")
        
        # Keep asking until a valid directory is provided
        while True:
            directory = input("\nPlease enter the directory path to collect from (or '.' for current directory): ").strip()
            
            # Handle empty input
            if not directory:
                continue
                
            # Convert '.' to current directory
            if directory == '.':
                directory = os.getcwd()
            
            # Check if directory exists
            if os.path.exists(directory):
                break
            else:
                print(f"Error: Directory '{directory}' does not exist. Please try again.")
    
    # Combine default and user-specified exclusions
    exclude_dirs = ['.git', '__pycache__', 'node_modules', 'venv']
    if args.exclude_dirs:
        exclude_dirs.extend(args.exclude_dirs)
    
    exclude_extensions = ['.pyc', '.pyo', '.pyd', '.exe', '.dll', '.so', '.dylib']
    if args.exclude_extensions:
        exclude_extensions.extend(args.exclude_extensions)
    
    # Run the collection
    collect_configs(directory, args.output, exclude_dirs, exclude_extensions)
