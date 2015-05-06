call unite#util#set_default('g:unite_template_dirs', ["~/.vim/template"])

let s:source = {
  \ 'name': 'template',
  \ }

function! s:source.gather_candidates(args, context)
  let cand = []
  for dir in g:unite_template_dirs
    let path = expand(dir)
    if isdirectory(path)
      let filelist = glob(path."/*")
      let splitted = split(filelist, "\n")
      for file in splitted
        let basename = fnamemodify(file, ":t")
        call add(cand, {"path": file, "name": basename})
      endfor
    endif
  endfor
  return map(cand, '{
    \ "word": v:val["name"],
    \ "source": "template",
    \ "kind": "file",
    \ "action__path": v:val["path"],
    \ }')
endfunction

function! unite#sources#template#define()
  return s:source
endfunction
call unite#custom#default_action("source/template/*", "read")
