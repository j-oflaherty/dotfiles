_copy(){
	cat | xclip -selection clipboard
}
_paste(){
    xclip -selection clipboard -o
}