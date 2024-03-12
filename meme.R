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

# Here are all the properties we will be using to simplify things:
text_properties <- list(
  text = c("p > 0.05", "stats220 student", "p < 0.01"),
  size = c(20, 20, 20),
  color = "black",
  location = c("+60+110", "+30+50", "+390+320"),
  gravity = c("northeast", "center", "northeast")
)

old_girlfriend_box <- image_blank(width=150, height=50, color="#CCCCCC80")
main_character_box <- image_blank(width=200, height=80, color="#CCCCCC80")
new_girlfriend_box <- image_blank(width=150, height=50, color="#CCCCCC80")


background_final <- background %>%
  # Old Girlfriend part
  image_composite(old_girlfriend_box, offset="+30+100", gravity="northeast") %>%
  image_annotate(text=text_properties$text[1], size=text_properties$size[1], color=text_properties$color, location=text_properties$location[1], gravity=text_properties$gravity[1]) %>%
  # Main Character
  image_composite(main_character_box, offset="+30+50", gravity="center") %>%
  image_annotate(text=text_properties$text[2], size=text_properties$size[2], color=text_properties$color, location=text_properties$location[2], gravity=text_properties$gravity[2]) %>%
  # New Girlfriend
  image_composite(new_girlfriend_box, offset="+350+300", gravity="northeast") %>%
  image_annotate(text=text_properties$text[3], size=text_properties$size[3], color=text_properties$color, location=text_properties$location[3], gravity=text_properties$gravity[3])

print(background_final)

# We need to use the image.append function so we will do a side by side comparison
meme_comparison <- c(background_final, background_resized) %>%
  image_append(stack = TRUE)
print(meme_comparison)


# Saving the meme
background_final %>% image_write("./output/my_meme.png")

# Let us animate the meme now

# I found some frames online 
frame1 <- image_read("./assets/gif1.png")
frame1_resized <- image_resize(frame1, "601x401")
frame2 <- image_read("./assets/gif2.jpeg")
frame2_resized <- image_resize(frame2, "601x401")

# Add caption one
caption <- "Hmm, should I switch to p < 0.01?"
background_with_thought <- background %>%
  image_annotate(caption, size = 20, color = 'blue', location = 'north')

# Add frame annotated and aurora effect
frame1_highlighted <- frame1_resized %>%
  image_modulate(brightness = 150, saturation = 120) %>%
  image_annotate("STATISTICAL SIGNIFICANCE", size = 20, color = 'green', location = 'south')

# The reality....
frame2_fail <- frame2_resized %>%
  image_annotate("You can't do maths", size = 20, color = 'red', location = 'center')
animation_frames <- c(background_final, background_with_thought, frame1_highlighted, frame2_fail)
animation <- image_animate(animation_frames, fps = 0.5)

# Save the GIF to the ouptut folder
image_write(animation, "./output/my_animation.gif")