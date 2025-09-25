package com.example.moffatbaylodge.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.math.BigDecimal;
import java.util.List;

// Controller for room booking page, handles GET roombooking

@Controller
public class RoomBookingController {

    @GetMapping("/roombooking")
    public String showRooms(Model model) {
        model.addAttribute("rooms", List.of(
                new Room(1L, "1 King Bed, Non-Smoking", new BigDecimal("168.00"),
                        "Alarm Clock, Bathroom Amenities, Coffee/Tea Maker, Desk, Free Wi-Fi (high-speed) Hair Dryer HDTV In-Room, Temperature Control Iron Microwave",
                        "/images/rooms/king.jpg",
                        "Alarm Clock · Coffee/Tea · Wi-Fi · HDTV"),

                new Room(2L, "Double Queen Beds, Non-Smoking", new BigDecimal("157.50"),
                        "Alarm Clock, Bathroom Amenities, Coffee/Tea Maker, Desk, Free Wi-Fi (high-speed) Hair Dryer HDTV In-Room",
                        "/images/rooms/double-queen.jpg",
                        "Free Wi-Fi · HDTV · Coffee/Tea"),

                new Room(3L, "Queen Bed, Non-Smoking", new BigDecimal("141.75"),
                        "Alarm Clock, Bathroom Amenities, Coffee/Tea Maker, Desk, Free Wi-Fi (high-speed) Hair Dryer HDTV In-Room",
                        "/images/rooms/Queen.jpg",
                        "Free Wi-Fi · HDTV · Coffee/Tea"),

                new Room(4L, "Double Full Beds, Non-Smoking", new BigDecimal("126.00"),
                        "Alarm Clock, Bathroom Amenities, Coffee/Tea Maker, Desk, Free Wi-Fi (high-speed) Hair Dryer HDTV In-Room",
                        "/images/rooms/double-full-beds.jpg",
                        "Free Wi-Fi · HDTV · Coffee/Tea")
        ));
        return "roombooking";
    }
    // DTO for the room details
    public static class Room {
        private final Long id;
        private final String name;
        private final BigDecimal price;
        private final String shortDescription;
        private final String imageUrl;
        private final String inlineAmenities;

        public Room(Long id, String name, BigDecimal price, String shortDescription,
                    String imageUrl, String inlineAmenities) {
            this.id = id;
            this.name = name;
            this.price = price;
            this.shortDescription = shortDescription;
            this.imageUrl = imageUrl;
            this.inlineAmenities = inlineAmenities;
        }

        public Long getId() { return id; }
        public String getName() { return name; }
        public BigDecimal getPrice() { return price; }
        public String getShortDescription() { return shortDescription; }
        public String getImageUrl() { return imageUrl; }
        public String getInlineAmenities() { return inlineAmenities; }
    }
}

