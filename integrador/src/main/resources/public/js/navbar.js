function toggle(id, id2) {
    var n = document.getElementById(id);
	if (n.style.display != 'none') {
	    n.style.display = 'none';
        document.getElementById(id2).setAttribute('aria-expanded', 'false');
    }
    else {
        n.style.display = '';
        document.getElementById(id2).setAttribute('aria-expanded', 'true');
    }
}