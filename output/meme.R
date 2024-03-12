# This is the R script used to create a new meme

# Import dependencies 
# install.packages("magick")
library(magick)

# Read and display the inspiration meme
inspo_meme <- image_read("./assets/inspo_meme.jpg")
print(inspo_meme)

# Let's create the new meme
# The plan here is to adapt the existing meme to be have a funny twist surrounding the concept of statistical significance
# Convert .webp to png
backgroundWebP <- image_read("./assets/backgroundWebp.webp")
background_resized <- image_resize(backgroundWebP, "601x401")
backgroundPng <- image_write(background_resized, "./output/background.png") # Same wxh dimensions as our inspo
background <- image_read("./output/background.png")
print(background)
# print(background) DEBUGGING 

# Now that we have the basic image let's add some text

# Old girlfriend text
old_girlfriend_background <- image_blank(width=150, height=50, color="#CCCCCC80") # Added transparency to the color
background <- image_composite(background, old_girlfriend_background, offset="+30+100", gravity="northeast")
background <- image_annotate(background, text="p > 0.05", size=20, color="black", location="+60+110", gravity="northeast")

# Main character text
main_character_background <- image_blank(width=200, height=80, color="#CCCCCC80") # Added transparency to the color
background <- image_composite(background, main_character_background, offset="+30+0", gravity="center")
background_with_mc_og_annotations <- image_annotate(background, text="I fail to reject\nwhen p value < 0.05", size=20, color="black", location="+30+0", gravity="center")
print(background_with_mc_og_annotations) # DEBUGGING