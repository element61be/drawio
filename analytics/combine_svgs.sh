#!/bin/bash

# Directory containing SVG files
svg_dir="/c/Users/ReinoutLesage/Downloads/qlik-cloud-icons-main/qlik-cloud-icons-main/svg"
output_file="Qlik.xml"

# Start the XML file
echo "<mxlibrary>[" > $output_file

# Loop through all SVG files in the directory
for svg_file in "$svg_dir"/*.svg; do
  # Read the SVG content and encode it in base64
  svg_content=$(base64 -w 0 "$svg_file")
  
  # Create the XML entry for the SVG file
  cat <<EOL >> $output_file
  {
    "xml": "&lt;mxGraphModel&gt;&lt;root&gt;&lt;mxCell id=\"0\"/&gt;&lt;mxCell id=\"1\" parent=\"0\"/&gt;&lt;mxCell id=\"2\" value=\"\" style=\"shape=image;verticalLabelPosition=bottom;labelBackgroundColor=default;verticalAlign=top;aspect=fixed;imageAspect=0;editableCssRules=.*;image=data:image/svg+xml,${svg_content};\" vertex=\"1\" parent=\"1\"&gt;&lt;mxGeometry width=\"40\" height=\"40\" as=\"geometry\"/&gt;&lt;/mxCell&gt;&lt;/root&gt;&lt;/mxGraphModel&gt;",
    "w": 40,
    "h": 40,
    "aspect": "fixed"
  },
EOL
done

# Remove the last comma and close the XML file
sed -i '$ s/,$//' $output_file
echo "]</mxlibrary>" >> $output_file

echo "Combined XML file created at $output_file"