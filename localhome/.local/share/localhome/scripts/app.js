// Setup search with Google
document.getElementById("search-submit").onclick = function() {
    var search = document.getElementById("search-field").value
    if (search != "") {
        window.location = "http://google.com/search?q="+search
    }
};

document.getElementById("search-field").onkeypress = function(e) {
    if (e.key == "Enter") {
        document.getElementById("search-submit").click();
    }
}
