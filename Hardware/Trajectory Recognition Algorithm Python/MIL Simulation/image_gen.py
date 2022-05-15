def image_generate():
    #This function doesn't have any parameter the input file from which the acceleration values are taken is called 
    #'acc.csv'
    #Here t is the smapling time 
    #The created images are saved by the name 'image_<num>.jpeg' where num is the serial number corresponding to the image 
    #generated at different stages of image processing and the final csv file is named as 'image_final.csv'
    
    #Calling the required libraries
    #%matplotlib inline
    import numpy as np
    from matplotlib import pyplot as plt
    import PIL
    from PIL import Image 

    
    
    #acc.csv file will contain the the x and y accerlation with sampling rate,t
    t = 1/50                                           #sampling time
    file = 'acc.csv'                                   #input file
    data_x = []                                        #array to store x acceleration     
    data_y = []                                        #array to store y acceleration
    num_points = 0                                     #number of data points      

    with open(file, "r") as f:               #,encoding = "utf-16" <--add this inside open() incase of encoding error
        for row in f:
            num_points += 1
            elements = row.split(',')
            data_x.append(float(elements[0]))
            data_y.append(float(elements[1]))

    data_x.reverse()
    data_y.reverse()
    #I've reversed the just in case if the file contains the data in the order of newest to oldest
    
    


    #The following block of code does the integration to convert the acc points into position points
    #Initialising the velocity and position to be zero
    #velocity[i] = velocity[i-1]   +   (acc[i]+acc[i-1])/2  *  t
    #position[i] = position[i-1]   +   (velocity[i]+velocity[i-1])/2  *  t
    velo_x = [0]
    velo_y = [0]
    pos_x = [0]
    pos_y = [0]

    velo_x.append(data_x[0]/2*t)
    velo_y.append(data_y[0]/2*t)


    for i in range(1,num_points):
        pos_x.append((velo_x[i]+velo_x[i-1])/2*t+pos_x[i-1])
        pos_y.append((velo_y[i]+velo_y[i-1])/2*t+pos_y[i-1])
    
        velo_x.append((data_x[i]+data_x[i-1])/2*t+velo_x[i-1])
        velo_y.append((data_y[i]+data_y[i-1])/2*t+velo_y[i-1])

    pos_x.append((velo_x[num_points]+velo_x[num_points-1])/2*t+pos_x[num_points-1])
    pos_y.append((velo_y[num_points]+velo_y[num_points-1])/2*t+pos_y[num_points-1])
    
    
    



    #This block of code converts the the sets of points into an image 
    pos_x = np.asarray(pos_x)
    pos_y = np.asarray(pos_y)
    plt.plot(pos_x,pos_y,'ko')
    plt.axis('off')
    plt.savefig('image_colour.jpeg')


    
    #This block of code converts the image to into the desired size and the convert it into a monochrome image
    img = Image.open('image_colour.jpeg')                      # open colour image
    img = img.convert('L')                                # convert image to black and white
    img = img.resize((20, 20), PIL.Image.ANTIALIAS)
    img.save('image_bw.jpeg')


    
    #The following code converts the monochrome image into data points for a csv file
    img_array = (plt.imread('image_bw.jpeg'))
    final_array = np.zeros((28,28))
    final_array[4:24,4:24] = (1-img_array/255)
    return final_array
    #Here final_array is the final array
