App.chatroom = App.cable.subscriptions.create("ChatroomChannel", {
    connected: function() {},
    disconnected: function() {},
    received: function(data) {
        var chatroom = $("#chatrooms-list").find(
            "[data-chatroom-id='" + data["chatroom_id"] + "']"
        );

        if (data["window"] !== undefined) {
            var chatroom_visible = chatroom.is(":visible");

            if (chatroom_visible) {
                var messages_visible = chatroom.find(".card-body").is(":visible");

                if (!messages_visible) {
                    chatroom.removeClass("card-default").addClass("card-success");
                    chatroom.find(".card-body").toggle();
                }
                chatroom
                    .find(".messages-list")
                    .find("ul")
                    .append(data["message"]);
            } else {
                $("#chatrooms-list").append(data["window"]);
                chatroom = $("#chatrooms-list").find(
                    "[data-chatroom-id='" + data["chatroom_id"] + "']"
                );
                chatroom.find(".card-body").toggle();
            }
        } else {
            chatroom.find("ul").append(data["message"]);
        }

        var messages_list = chatroom.find(".messages-list");
        var height = messages_list[0].scrollHeight;
        messages_list.scrollTop(height);
    },
    speak: function(message) {
        return this.perform("speak", {
            message: message
        });
    }
});
$(document).on("submit", ".new_message", function(e) {
    e.preventDefault();
    var values = $(this).serializeArray();
    App.chatroom.speak(values);
    $(this).trigger("reset");
});