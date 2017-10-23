"comment
" 当新建 .h .c .hpp .cpp .mk .sh等文件时自动调用SetTitle 函数  
autocmd BufNewFile *.[ch],*.hpp,*.cpp,Makefile,*.mk,*.sh exec ":call SetTitle()"   
nmap <F3> :call SetFunComment()<CR><CR>
nmap <F4> :call AddModify()<CR><CR>
" 加入注释  
let username="hyb" 
func SetComment()  
    call setline(1,"/*================================================================")   
    call append(line("."),   "*   Copyright (C) ".strftime("%Y")." . All rights reserved.")  
    call append(line(".")+1, "*   ")   
    call append(line(".")+2, "*   文件名称：".expand("%:t"))   
    call append(line(".")+3, "*   创 建 者：".g:username)  
    call append(line(".")+4, "*   创建日期：".strftime("%Y年%m月%d日"))   
    call append(line(".")+5, "*   描    述：")   
    call append(line(".")+6, "*")  
    call append(line(".")+7, "================================================================*/")   
    call append(line(".")+8, "")  
    call append(line(".")+9, "")  
endfunc  
  
" 加入shell,Makefile注释  
func SetComment_sh()  
    call setline(3, "#================================================================")   
    call setline(4, "#   Copyright (C) ".strftime("%Y")." . All rights reserved.")  
    call setline(5, "#   ")   
    call setline(6, "#   文件名称：".expand("%:t"))   
    call setline(7, "#   创 建 者：".g:username)  
    call setline(8, "#   创建日期：".strftime("%Y年%m月%d日"))   
    call setline(9, "#   描    述：")   
    call setline(10, "#")  
    call setline(11, "#================================================================")  
    call setline(12, "")  
    call setline(13, "")  
endfunc   
  
" 定义函数SetTitle，自动插入文件头   
func SetTitle()  
  
    if &filetype == 'make'   
        call setline(1,"")   
        call setline(2,"")  
        call SetComment_sh()  
  
    elseif &filetype == 'sh'   
        call setline(1,"#!/usr/bin/bash")   
        call setline(2,"")  
        call SetComment_sh()  
          
    else  
         call SetComment()  
         if expand("%:e") == 'hpp'   
          call append(line(".")+10, "#ifndef _".toupper(expand("%:t:r"))."_H")   
          call append(line(".")+11, "#define _".toupper(expand("%:t:r"))."_H")   
          call append(line(".")+12, "#ifdef __cplusplus")   
          call append(line(".")+13, "extern \"C\"")   
          call append(line(".")+14, "{")   
          call append(line(".")+15, "#endif")   
          call append(line(".")+16, "")   
          call append(line(".")+17, "#ifdef __cplusplus")   
          call append(line(".")+18, "}")   
          call append(line(".")+19, "#endif")   
          call append(line(".")+20, "#endif //".toupper(expand("%:t:r"))."_H")   
  
         elseif expand("%:e") == 'h'   
        call append(line(".")+10, "#pragma once")   
  
         elseif &filetype == 'c'   
        call append(line(".")+10,"#include \"".expand("%:t:r").".h\"")   
  
         elseif &filetype == 'cpp'   
        call append(line(".")+10, "#include \"".expand("%:t:r").".h\"")   
  
         endif  
  
    endif  
endfunc  
func SetFunComment()
    let printfstr=""
    let printfstr.=escape(getline(line(".")),'"')." "
    call append(line(".")-1,"/*************************************")
    let list1=split(printfstr,"(")
    let list2 = split(list1[0]," ")
    let funName="函 数 名："
    let funName.=list2[1]
    let returnPara = "返 回 值："
    let returnPara.=list2[0]
    let fun="功能描述："
    let output="输出参数："
    call append(line(".")-1,funName)
    call append(line(".")-1,fun)
    let list = split(list1[1],",")
    let paraNum = len(list)
    let i = 0
    let para="输入参数："
    if paraNum>1
        let para=""
        while 1 < paraNum-1
            if i==0
    		let para="输入参数："
	    else
		let para="   "
	    endif
		let para.=list[i]
		call append(line(".")-1,para)
		let i=i+1
	endwhile
	let listend=split(list[paraNum-1],")")
	let para=""
        let para.=listend[0]
	call append(line(".")-1,para)
    else
	let listend = split(list[paraNum-1],")")
	let para="输入参数："
	let para.=listend[0]
	call append(line(".")-1,para)
    endif
    call append(line(".")-1,output)
    call append(line(".")-1,returnPara)
    call append(line(".")-1,"")
    call append(line(".")-1,"日    期：".strftime("%Y年%m月%d日"))
    call append(line(".")-1,"作    者：".g:username)
    call append(line(".")-1,"修改历史:新生成函数")
    call append(line(".")-1,"********************************************/")
endfun
func AddModify()
    call append(line(".")-1,"日    期：".strftime("%Y年%m月%d日"))
    call append(line(".")-1,"作    者：".g:username)
    call append(line(".")-1,"修改日志:")
endfun
