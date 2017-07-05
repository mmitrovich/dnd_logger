function filterEntries() {
    var input, filter, p, i;
    input = document.getElementById("entry_filter");
    filter = input.value.toUpperCase();
    p = document.querySelectorAll('p.log_entry');
    for (i = 0; i < p.length; i++) {
        if (p[i].textContent.toUpperCase().indexOf(filter) > -1) {
            p[i].style.display = "";
        } else {
            p[i].style.display = "none";
        }
    }
}



