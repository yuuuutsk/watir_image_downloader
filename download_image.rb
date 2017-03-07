require "watir"
require "open-uri"
require "fastimage"
require "pry"

keyword = ARGV[0]
n_images = ARGV[1].to_i

browser = Watir::Browser.new :chrome
browser.goto(URI.escape("https://www.google.co.jp/search?source=lnms&tbm=isch&q=%s" % keyword))

image_urls = []
saved_images = []
i = 0
next_index = 0
min_width = 100
min_height = 100

while saved_images.size < n_images
    # stock image urls
    browser.images(class: /rg_ic rg_i/)[i].click
    sleep(0.5)
    for image in browser.images(class: /irc_mi/)
        url = image.src
        w, h = FastImage.size(url)
        # only save jpeg format
        if url.size > 0 and not image_urls.include?(url) and FastImage.type(url) == :jpeg and w and h and w > min_width and h > min_height
            image_urls.push(url)
        end
    end
    i += 1

    if image_urls.size <= saved_images.size
        next
    end

    # download image
    begin
        file_name = "downloads/%d.jpg" % next_index

        p "Save '%s' into '%s'" % [image_urls[next_index], file_name]
        open(image_urls[next_index], "rb") do |file|
            open(file_name, "wb") do |out|
                out.write(file.read)
            end
        end
        saved_images.push(image_urls[next_index])
        next_index += 1
    rescue Exception => e
        image_urls.slice!(next_index)
        p "Failed! " + e.message
    end
end
