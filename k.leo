<?xml version="1.0" encoding="utf-8"?>
<!-- Created by Leo: http://leoeditor.com/leo_toc.html -->
<leo_file xmlns:leo="http://leoeditor.com/namespaces/leo-python-editor/1.1" >
<leo_header file_format="2"/>
<globals/>
<preferences/>
<find_panel_settings/>
<vnodes>
<v t="caminhante.20200313155940.1"><vh>@settings</vh>
<v t="caminhante.20200619162742.1"><vh>@command open-url-here @key=Ctrl-U</vh></v>
<v t="caminhante.20200618180759.1"><vh>@command terminal-here @key=Alt-T</vh></v>
<v t="caminhante.20200828195842.1"><vh>@data abbreviations</vh></v>
<v t="caminhante.20200313155940.99"><vh>nodeActions</vh>
<v t="caminhante.20200604232050.1"><vh>@cmd *</vh></v>
<v t="caminhante.20200619161501.1"><vh>@download *</vh></v>
<v t="caminhante.20200619155412.1"><vh>@duck *</vh></v>
<v t="caminhante.20200927204806.1"><vh>@gcc|@gcc .* [X]</vh></v>
<v t="caminhante.20200808174417.1"><vh>@js|@js .* [X]</vh></v>
<v t="caminhante.20200912185313.1"><vh>@lua|@lua .* [X]</vh></v>
<v t="caminhante.20210501142945.2"><vh>@mkdir *</vh></v>
<v t="caminhante.20210501142945.3"><vh>@mv file://*</vh></v>
<v t="caminhante.20200619213937.1"><vh>@node|@node .* [X]</vh></v>
<v t="caminhante.20210501142945.4"><vh>@rmdir /*/</vh></v>
<v t="caminhante.20200618203115.1"><vh>@run|@run .* [X]</vh></v>
<v t="caminhante.20200619154823.1"><vh>@web *</vh></v>
</v>
</v>
<v t="caminhante.20210502132430.2"><vh>Kernel protótipo</vh>
<v t="caminhante.20210502132600.1"><vh>@path .</vh>
<v t="caminhante.20210502132611.2"><vh>/.git/</vh></v>
<v t="caminhante.20210502143646.1"><vh>/src/</vh>
<v t="caminhante.20210502143700.1"><vh>@file Makefile</vh></v>
<v t="caminhante.20210502143746.1"><vh>@file kernel.asm</vh></v>
</v>
<v t="caminhante.20210502132611.1"><vh>@auto README.md</vh></v>
<v t="caminhante.20210502132602.1"><vh>k.leo</vh></v>
<v t="caminhante.20210502132602.3"><vh>LICENSE</vh></v>
</v>
<v t="caminhante.20210502134059.1"><vh>@project time &lt;0+0.6=0.6 days, 3.3%&gt;</vh>
<v t="caminhante.20210502134124.1"><vh>Multiboot em Asm puro &lt;0+0.2=0.2 days, 10%&gt;</vh></v>
<v t="caminhante.20210502134740.1"><vh>Ramdisk &lt;0.1 days, 0%&gt;</vh></v>
<v t="caminhante.20210502135046.1"><vh>Interpretador ELF &lt;0.1 days, 0%&gt;</vh></v>
<v t="caminhante.20210502143404.1"><vh>Tabela de processos &lt;0.1 days, 0%&gt;</vh></v>
<v t="caminhante.20210502143508.1"><vh>Syscalls na kernelland &lt;0.1 days, 0%&gt;</vh></v>
</v>
</v>
</vnodes>
<tnodes>
<t tx="caminhante.20200313155940.1"></t>
<t tx="caminhante.20200313155940.99">@language python
</t>
<t tx="caminhante.20200604232050.1">import subprocess

def execute (cmd):
    return subprocess.run(cmd,shell=True,universal_newlines=True,stderr=subprocess.STDOUT,stdout=subprocess.PIPE).stdout

if c.isChanged(): c.save()

path = c.getNodePath(c.p)
g.os.chdir(path)

command = ''.join(c.p.h.split('@cmd ')[1:])
command = "cat &lt;&lt;'EOFEOFEOFEOFEOFEOF' | bash\n"+command+'\nEOFEOFEOFEOFEOFEOF'
g.es(c.p.h)
c.p.b += execute(command)

c.save()
</t>
<t tx="caminhante.20200618180759.1">@language python
import subprocess

def execute (cmd):
    return subprocess.run(cmd,shell=True,universal_newlines=True,stderr=subprocess.STDOUT,stdout=subprocess.PIPE).stdout

if c.isChanged(): c.save()
path = c.getNodePath(c.p)

execute('terminator --working-directory="'+path+'" --new-tab')
</t>
<t tx="caminhante.20200618203115.1">@language python
import subprocess

# def getpath (p):
    # dict = c.scanAllDirectives(p)
    # d = dict.get("path")
    # if p.isAnyAtFileNode():
        # filename = p.anyAtFileNodeName()
        # filename = g.os_path_join(d,filename)
        # if filename:
            # d = g.os_path_dirname(filename)
    # if d is None:
        # return ""
    # else:
        # return g.os_path_normpath(d)

# if c.isChanged(): c.save()

def execute (cmd):
    return subprocess.run(cmd,shell=True,universal_newlines=True,stderr=subprocess.STDOUT,stdout=subprocess.PIPE).stdout

path = c.getNodePath(c.p)
g.os.chdir(path)

w = c.frame.body.wrapper
s1,s2 = w.getSelectionRange()

if s1 == s2:
    code = c.p.b
else:
    linebr = c.p.b.find('\n',s2)
    if linebr == -1: linebr = len(c.p.b)
    code = c.p.b[s1:s2]

g.es(c.p.h)

command = "cat &lt;&lt;'EOFEOFEOFEOFEOFEOF' | bash\n"+code+'\nEOFEOFEOFEOFEOFEOF'

# if s1 == s2:
    # c.p.b += '\n' + execute(command)
# else:
    # c.p.b = c.p.b[0:linebr] + '\n' + execute(command) + c.p.b[linebr:]

cpc = c.p.copy()
novoNo = cpc.insertAsLastChild()
novoNo.h = c.p.h
novoNo.b = execute(command)
c.redraw()

c.save()
w.setSelectionRange(s1,s2)
</t>
<t tx="caminhante.20200619154823.1">import subprocess

def execute (cmd):
    return subprocess.run(cmd,shell=True,universal_newlines=True,stderr=subprocess.STDOUT,stdout=subprocess.PIPE).stdout

if c.isChanged(): c.save()

url = ''.join(c.p.h.split('@web ')[1:])
command = 'lynx -image_links -dump "'+url+'"'
g.es(c.p.h)
c.p.b = execute(command)

c.save()
</t>
<t tx="caminhante.20200619155412.1">import subprocess
import urllib.parse

def execute (cmd):
    return subprocess.run(cmd,shell=True,universal_newlines=True,stderr=subprocess.STDOUT,stdout=subprocess.PIPE).stdout

if c.isChanged(): c.save()

search = ''.join(c.p.h.split('@duck ')[1:])
searchenc = urllib.parse.quote(search)
command = 'lynx -dump "https://duckduckgo.com/html/?q='+searchenc+'&amp;t=seamonkey"'
g.es(c.p.h)
c.p.b = execute(command)

c.save()
</t>
<t tx="caminhante.20200619161501.1">import subprocess

def execute (cmd):
    return subprocess.run(cmd,shell=True,universal_newlines=True,stderr=subprocess.STDOUT,stdout=subprocess.PIPE).stdout

if c.isChanged(): c.save()

path = c.getNodePath(c.p)
g.os.chdir(path)

url = ''.join(c.p.h.split('@download ')[1:])
command = 'wget --no-config --continue --no-verbose --adjust-extension --tries=3 --content-on-error "'+url+'"'
g.es(c.p.h)
c.p.b += execute(command)

c.save()
</t>
<t tx="caminhante.20200619162742.1">@language python
# if c.isChanged(): c.save()

w = c.frame.body.wrapper
b = c.p.b
i,j = w.getSelectionRange()

selecao = b[i:j]

cpc = c.p.copy()
novoNo = cpc.insertAsLastChild()
c.setHeadString(novoNo, '@web '+selecao)
c.selectPosition(novoNo)
c.redraw()
</t>
<t tx="caminhante.20200619213937.1">import subprocess
import re

def execute (cmd):
    return subprocess.run(cmd,shell=True,universal_newlines=True,stderr=subprocess.STDOUT,stdout=subprocess.PIPE).stdout

path = c.getNodePath(c.p)
g.os.chdir(path)

code = re.sub(r'^#|\n+#', '\n///', g.getScript(c,c.p))

g.es(c.p.h)

command = "cat &lt;&lt;'EOFEOFEOFEOFEOFEOF' | node\n"+code+'\nEOFEOFEOFEOFEOFEOF'

c.p.b += '\n' + execute(command)
</t>
<t tx="caminhante.20200808174417.1">import subprocess
import re

def execute (cmd):
    return subprocess.run(cmd,shell=True,universal_newlines=True,stderr=subprocess.STDOUT,stdout=subprocess.PIPE).stdout

path = c.getNodePath(c.p)
g.os.chdir(path)

code = re.sub(r'^#|\n+#', '\n///', g.getScript(c,c.p))

g.es(c.p.h)

command = "cat &lt;&lt;'EOFEOFEOFEOFEOFEOF' | js\n"+code+'\nEOFEOFEOFEOFEOFEOF'

c.p.b += '\n' + execute(command)
</t>
<t tx="caminhante.20200828195842.1">@tabwidth -2
</t>
<t tx="caminhante.20200912185313.1">import subprocess
import re

def execute (cmd):
    return subprocess.run(cmd,shell=True,universal_newlines=True,stderr=subprocess.STDOUT,stdout=subprocess.PIPE).stdout

path = c.getNodePath(c.p)
g.os.chdir(path)

code = re.sub(r'^#|\n+#', '\n---', g.getScript(c,c.p))

g.es(c.p.h)

command = "cat &lt;&lt;'EOFEOFEOFEOFEOFEOF' | lua\n"+code+'\nEOFEOFEOFEOFEOFEOF'

c.p.b += '\n' + execute(command)
</t>
<t tx="caminhante.20200927204806.1">import subprocess
import re

def execute (cmd):
    return subprocess.run(cmd,shell=True,universal_newlines=True,stderr=subprocess.STDOUT,stdout=subprocess.PIPE).stdout

path = c.getNodePath(c.p)
g.os.chdir(path)

code = re.sub(r'^#@|\n+#@', '\n///', g.getScript(c,c.p))
args = ''.join(c.p.h.split('@gcc ')[1:])

g.es(c.p.h)

command = "cat &lt;&lt;'EOFEOFEOFEOFEOFEOF' | gcc -xc - -Wall -Werror -std=gnu11 -c -o /dev/null \n"+code+'\nEOFEOFEOFEOFEOFEOF'

c.p.b += '\n' + execute(command)
# g.es(command)
</t>
<t tx="caminhante.20210501142945.2">import subprocess

def execute (cmd):
    return subprocess.run(cmd,shell=True,universal_newlines=True,stderr=subprocess.STDOUT,stdout=subprocess.PIPE).stdout

path = c.getNodePath(c.p)
g.os.chdir(path)

path = ''.join(c.p.h.split('@mkdir ')[1:])
cmd = 'mkdir -p "' + path + '"'
g.es(c.p.h)
execute(cmd)
c.p.h = '/'+path+'/'
c.p.b = '@path ' + path
</t>
<t tx="caminhante.20210501142945.3">import subprocess

def execute (cmd):
    return subprocess.run(cmd,shell=True,universal_newlines=True,stderr=subprocess.STDOUT,stdout=subprocess.PIPE).stdout

path = c.getNodePath(c.p)
g.os.chdir(path)

path = ''.join(c.p.h.split('@mv file://')[1:])
cmd = 'mv -v "' + path + '" ./'
g.es(c.p.h)
g.es(execute(cmd))
</t>
<t tx="caminhante.20210501142945.4">import subprocess
import shutil

def execute (cmd):
    return subprocess.run(cmd,shell=True,universal_newlines=True,stderr=subprocess.STDOUT,stdout=subprocess.PIPE).stdout

ps = c.p.parents()
for par in ps:
    break
path = c.getNodePath(par)
g.os.chdir(path)

path = ''.join(c.p.h.split('@rmdir /')[1:]).split('/')[0]
shutil.rmtree(path)
</t>
<t tx="caminhante.20210502132430.2"></t>
<t tx="caminhante.20210502132600.1"></t>
<t tx="caminhante.20210502132602.1"></t>
<t tx="caminhante.20210502132602.3"></t>
<t tx="caminhante.20210502132611.2">@path .git</t>
<t tx="caminhante.20210502134059.1" annotate="7d710028580800000070726f6772657373710147400aaaaaaaaaaaab580800000074696d655f7265717102473fe3333333333333752e" icons="5d71007d7101285804000000747970657102580400000066696c657103680358450000002f686f6d652f757365722f62696e2f6c656f2d656469746f722f6c656f2f7468656d65732f6c656f5f6461726b5f302f49636f6e732f636c656f2f7072673030302e706e677104580700000072656c506174687105580f000000636c656f2f7072673030302e706e677106580500000077686572657107580e0000006265666f7265486561646c696e6571085807000000796f666673657471094b005807000000786f6666736574710a4b02580400000078706164710b4b0158020000006f6e710c5805000000766e6f6465710d5808000000636c656f49636f6e710e580100000031710f75612e"></t>
<t tx="caminhante.20210502134124.1" annotate="7d710028580800000074696d655f7265717101473fc9999999999999580800000070726f677265737371024b0a580700000064756564617465710358000000007104580700000064756574696d6571056804752e" icons="5d71007d7101285804000000747970657102580400000066696c657103680358450000002f686f6d652f757365722f62696e2f6c656f2d656469746f722f6c656f2f7468656d65732f6c656f5f6461726b5f302f49636f6e732f636c656f2f7072673031302e706e677104580700000072656c506174687105580f000000636c656f2f7072673031302e706e677106580500000077686572657107580e0000006265666f7265486561646c696e6571085807000000796f666673657471094b005807000000786f6666736574710a4b02580400000078706164710b4b0158020000006f6e710c5805000000766e6f6465710d5808000000636c656f49636f6e710e580100000031710f75612e"></t>
<t tx="caminhante.20210502134740.1" annotate="7d710028580800000074696d655f7265717101473fb999999999999a580800000070726f677265737371024b00580700000064756564617465710358000000007104752e" icons="5d71007d7101285804000000747970657102580400000066696c657103680358450000002f686f6d652f757365722f62696e2f6c656f2d656469746f722f6c656f2f7468656d65732f6c656f5f6461726b5f302f49636f6e732f636c656f2f7072673030302e706e677104580700000072656c506174687105580f000000636c656f2f7072673030302e706e677106580500000077686572657107580e0000006265666f7265486561646c696e6571085807000000796f666673657471094b005807000000786f6666736574710a4b02580400000078706164710b4b0158020000006f6e710c5805000000766e6f6465710d5808000000636c656f49636f6e710e580100000031710f75612e"></t>
<t tx="caminhante.20210502135046.1" annotate="7d710028580700000064756564617465710158000000007102580800000074696d655f7265717103473fb999999999999a580800000070726f677265737371044b00580c0000006e657874776f726b74696d6571056802752e" icons="5d71007d7101285804000000747970657102580400000066696c657103680358450000002f686f6d652f757365722f62696e2f6c656f2d656469746f722f6c656f2f7468656d65732f6c656f5f6461726b5f302f49636f6e732f636c656f2f7072673030302e706e677104580700000072656c506174687105580f000000636c656f2f7072673030302e706e677106580500000077686572657107580e0000006265666f7265486561646c696e6571085807000000796f666673657471094b005807000000786f6666736574710a4b02580400000078706164710b4b0158020000006f6e710c5805000000766e6f6465710d5808000000636c656f49636f6e710e580100000031710f75612e"></t>
<t tx="caminhante.20210502143404.1" annotate="7d710028580800000074696d655f7265717101473fb999999999999a580800000070726f677265737371024b00752e" icons="5d71007d7101285804000000747970657102580400000066696c657103680358450000002f686f6d652f757365722f62696e2f6c656f2d656469746f722f6c656f2f7468656d65732f6c656f5f6461726b5f302f49636f6e732f636c656f2f7072673030302e706e677104580700000072656c506174687105580f000000636c656f2f7072673030302e706e677106580500000077686572657107580e0000006265666f7265486561646c696e6571085807000000796f666673657471094b005807000000786f6666736574710a4b02580400000078706164710b4b0158020000006f6e710c5805000000766e6f6465710d5808000000636c656f49636f6e710e580100000031710f75612e"></t>
<t tx="caminhante.20210502143508.1" annotate="7d710028580800000074696d655f7265717101473fb999999999999a580800000070726f677265737371024b00752e" icons="5d71007d7101285804000000747970657102580400000066696c657103680358450000002f686f6d652f757365722f62696e2f6c656f2d656469746f722f6c656f2f7468656d65732f6c656f5f6461726b5f302f49636f6e732f636c656f2f7072673030302e706e677104580700000072656c506174687105580f000000636c656f2f7072673030302e706e677106580500000077686572657107580e0000006265666f7265486561646c696e6571085807000000796f666673657471094b005807000000786f6666736574710a4b02580400000078706164710b4b0158020000006f6e710c5805000000766e6f6465710d5808000000636c656f49636f6e710e580100000031710f75612e"></t>
<t tx="caminhante.20210502143646.1">@path src</t>
</tnodes>
</leo_file>
