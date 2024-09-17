<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.todolist.webapp.todolistwebapp.Task" %>
<html>
<head>
    <title>ToDoList WebApp</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    animation: {
                        rotate: 'rotate 10s linear infinite',
                    },
                    keyframes: {
                        rotate: {
                            '0%': {transform: 'rotate(0deg) scale(10)'},
                            '100%': {transform: 'rotate(-360deg) scale(10)'}
                        }
                    }
                }
            }
        }
    </script>
    <link href="https://cdn.jsdelivr.net/npm/flowbite@2.5.1/dist/flowbite.min.css" rel="stylesheet" />
</head>

<body class="flex justify-center items-center p-8">
<% ArrayList<Task> lista = (ArrayList<Task>) request.getAttribute("lista");%>
    <div class="border border-[#e5e5e8] rounded-lg max-w-[500px] w-full">
        <div class="p-6">
            <h1 class="tracking-tight text-3xl font-bold text-center">I Miei Todos</h1>
        </div>
        <div class="overflow-y-auto flex flex-col h-[400px] w-full p-6">
            <% String error = (String) request.getAttribute("error");
                if(error != null) {
            %>
            <div class="w-[75%] self-center p-1 rounded-lg bg-red-600 opacity-80 text-white text-center font-bold">
                <p><%=error%></p>
            </div>
            <%}%>

            <% for(int i = 0; i < lista.size(); i++) { %>
            <%String checked;%>
            <% if (lista.get(i).getChecked()) {
                checked = "line-through opacity-50 bg-[#dcfce7]";
            } else {
                 checked = "";
            }%>
            <div data-status="<%=lista.get(i).getChecked()%>" class="flex items-center justify-between min-h-28 px-4 py-6 mt-4 first-of-type:mt-0 bg-gray-100 group relative <%=checked%>" name="box" id="<%= lista.get(i).getid()%>" tabIndex="<%= lista.get(i).getid() %>">
                <span class="ease absolute left-0 top-0 h-0 w-0 border-t-2 border-black transition-all duration-1000 group-focus:w-full"></span>
                <span class="ease absolute right-0 top-0 h-0 w-0 border-r-2 border-black transition-all duration-1000 group-focus:h-full"></span>
                <span class="ease absolute bottom-0 right-0 h-0 w-0 border-b-2 border-black transition-all duration-1000 group-focus:w-full"></span>
                <span class="ease absolute bottom-0 left-0 h-0 w-0 border-l-2 border-black transition-all duration-1000 group-focus:h-full"></span>
                <p class="text-lg max-[400px]:text-sm font-medium w-32 max-[400px]:w-16 max-[400px]:text-center" name="box"> <%=lista.get(i).getDescription() %></p>
                <p class="text-base max-[400px]:text-sm flex items-center" name="box"><%=lista.get(i).getDate()%></p>
                <p class="hidden" name="box"><%=lista.get(i).getOriginalDate()%></p>
                <%if(lista.get(i).getChecked()) {%>
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-circle-check w-6 h-6 text-green-500" data-id="14">
                        <circle cx="12" cy="12" r="10"></circle>
                        <path d="m9 12 2 2 4-4"></path>
                    </svg>
                    <%}else{ %>
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-clock">
                        <circle cx="12" cy="12" r="10"/>

                    </svg>
                    <% } %>
            </div>
            <% } %>
        </div>
        <div class="h-[66px]">
            <div class="flex justify-center items-start transition-opacity duration-[600ms] opacity-0" id="formcontainer">
                <form action="/delete" method="post" id="form1">
                    <input type="hidden" name="idtask" class="idtask"/>
                    <button type="submit" form="form1" value="submit" class="formbutton focus:outline-none rounded-full text-sm w-max px-2.5 py-2.5 text-center" disabled>
                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 24 24" fill="none" stroke="#ec5333" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-x"><path d="M18 6 6 18"/><path d="m6 6 12 12"/></svg>
                    </button>
                </form>
                <form action="/modifychecked" method="post" id="form2">
                    <input type="hidden" name="idtask" class="idtask"/>
                    <button type="submit" form="form2" value="submit" class="formbutton focus:outline-none rounded-full text-sm w-max px-2.5 py-2.5 text-center" disabled>
                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 24 24" fill="none" stroke="#25b570" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-check" id="svg1">
                            <path d="M20 6 9 17l-5-5"/>
                        </svg>
                        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-clock hidden" id="svg2">
                            <circle cx="12" cy="12" r="10"/>
                            <polyline points="12 6 12 12 16 14"/>
                        </svg>
                    </button>
                </form>
                <button data-modal-target="modify-modal" data-modal-toggle="modify-modal" class="formbutton focus:outline-none rounded-full text-sm w-max px-2.5 py-2.5 text-center" type="button" disabled>
                    <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-pencil-line">
                        <path d="M12 20h9"/>
                        <path d="M16.376 3.622a1 1 0 0 1 3.002 3.002L7.368 18.635a2 2 0 0 1-.855.506l-2.872.838a.5.5 0 0 1-.62-.62l.838-2.872a2 2 0 0 1 .506-.854z"/>
                        <path d="m15 5 3 3"/>
                    </svg>
                </button>
            </div>
        </div>
        <form action ="/add" method="post" id="form4" class="flex items-center mx-6">
            <div class="w-3/4 flex flex-col">
                <div class="mb-5">
                    <label for="description" class="block mb-2 text-sm font-medium leading-none">Descrizione Evento:</label>
                    <input type="text" id="description" name="description" class="h-10 w-full rounded-md text-sm bg-gray-50 border border-gray-300 text-gray-900 focus:bg-[#ebeaef] focus:!border-2 focus:!border-black p-2.5" required />
                </div>
                <div class="mb-5">
                    <label for="date" class="block mb-2 text-sm font-medium leading-none">Data di scadenza:</label>
                    <input type="date" id="date" name="date" class="h-10 w-full rounded-md text-sm bg-gray-50 border border-gray-300 text-gray-900 focus:bg-[#ebeaef] focus:!border-2 focus:!border-black p-2.5" required/>
                </div>
            </div>
            <button type="submit" form="form4" value="submit" class="bg-black focus:ring-4 focus:outline-none rounded-full text-sm h-1/3 w-max ml-4 p-4 text-center">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-circle-plus"><circle cx="12" cy="12" r="10"/><path d="M8 12h8"/><path d="M12 8v8"/></svg>
            </button>
        </form>
    </div>

<div id="modify-modal" tabindex="-1" aria-hidden="true" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">
    <div class="relative p-4 w-full max-w-md max-h-full">
        <!-- Modal content -->
        <div class="relative bg-white rounded-lg shadow">
            <!-- Modal header -->
            <div class="flex items-center justify-between p-4 md:p-5 border-b rounded-t">
                <h3 class="text-xl font-semibold text-gray-900">Modifica la Task!</h3>
                <button type="button" class="end-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center" data-modal-hide="modify-modal">
                    <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/>
                    </svg>
                    <span class="sr-only">Close modal</span>
                </button>
            </div>
            <!-- Modal body -->
            <div class="p-4 md:p-5">
                <form class="space-y-4" action="/modifytask" method="post" id="form3">
                    <input type="hidden" name="idtask" class="idtask pisello"/>
                    <div>
                        <label for="description2" class="block mb-2 text-sm font-medium leading-none">Inserisci la nuova descrizione:</label>
                        <input type="text" name="description" id="description2" class="h-10 w-full rounded-md text-sm bg-gray-50 border border-gray-300 text-gray-900 focus:bg-[#ebeaef] focus:!border-2 focus:!border-black p-2.5" required />
                    </div>
                    <div>
                        <label for="date2" class="block mb-2 text-sm font-medium leading-none">Inserisci la nuova data di scadenza:</label>
                        <input type="date" name="date" id="date2" class="h-10 w-full rounded-md text-sm bg-gray-50 border border-gray-300 text-gray-900 focus:bg-[#ebeaef] focus:!border-2 focus:!border-black p-2.5" required />
                    </div>
                    <button type="submit" form="form3" value="submit" class="w-full text-white bg-black focus:outline-none font-medium rounded-lg text-sm px-5 py-2.5 text-center">Modifica</button>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    let boxes = document.getElementsByName("box");
    boxes.forEach((box) => {
        box.addEventListener("focusout", (event) => {
            setTimeout(() => {
                let anyBoxFocused = Array.from(boxes).some((b) => b === document.activeElement);
                if (!anyBoxFocused) {
                    [...document.getElementsByClassName("formbutton")].forEach((item) => {
                        item.setAttribute("disabled", true);
                    });
                    document.getElementById("formcontainer").style.opacity = "0";
                }
            }, 100);
        });

        box.addEventListener("click", (event) => {

            const targetTag = event.target.tagName.toLowerCase();
            if (targetTag === 'p' || targetTag === 'svg' || targetTag === 'path' || targetTag === 'circle') {
                return;
            }

            event.stopPropagation();
            [...document.getElementsByClassName("formbutton")].forEach((item) => {
                item.removeAttribute("disabled");
            });

            document.getElementById("formcontainer").style.opacity = "1";
            const paragraphs = box.querySelectorAll('p');
            let description = paragraphs[0].textContent;
            let date = paragraphs[2].textContent;
            document.getElementById("description2").value = description.trim();
            document.getElementById("date2").value = date;

            if (box.getAttribute("data-status") === "true") {
                document.getElementById("svg1").style.display = "none";
                document.getElementById("svg2").style.display = "block";
            } else {
                document.getElementById("svg1").style.display = "block";
                document.getElementById("svg2").style.display = "none";
            }

            [...document.getElementsByClassName("idtask")].forEach((item) => {
                item.value = event.target.id;
            });
        });

        box.querySelectorAll('p, svg, svg circle, svg circle path, svg circle polyline').forEach(element => {
            element.addEventListener('mousedown', function(event) {
                event.preventDefault();
                event.stopPropagation();
            });
        });
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.1/dist/flowbite.min.js"></script>
</body>
</html>