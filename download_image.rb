require "watir"
require "open-uri"

keyword = ARGV[0]
n_images = ARGV[1].to_i

browser = Watir::Browser.new :chrome
browser.goto(URI.escape("https://www.google.co.jp/search?source=lnms&tbm=isch&q=%s" % keyword))

image_urls = []
saved_images = []
i = 0
while saved_images.size < n_images
    browser.images(class: /rg_ic rg_i/)[i].click
    sleep(0.5)
    for image in browser.images(class: /irc_mi/)
        url = image.src
        if url.size > 0 and not image_urls.include?(url)
            image_urls.push(url)
        end
    end

    # download image
    begin
        file_name = image_urls[i].split("/")[-1]
        if(not file_name.match(/.jpg|.jpeg|.png|.gif|.bmp/))
          file_name = file_name.gsub("." + file_name.split(".")[-1], "")
          file_name = file_name + ".jpeg"
        end

        p "Save '" + image_urls[i] + "' into '" + file_name + "'"
        open(image_urls[i], "rb") do |file|
            open(file_name, "wb") do |out|
                out.write(file.read)
            end
        end
        saved_images.push(image_urls[i])
    rescue Exception
        p "Failed!"
    end

    i += 1
end
