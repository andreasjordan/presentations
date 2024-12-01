### Titel / Title

Intelligente Datenobjekte in PowerShell - Ein erster Schritt zur objektorientierten Programmierung

Intelligent data objects in PowerShell - A first step towards object-oriented programming

### Veranstaltung / Event

[PowerShell Saturday Karlsruhe 2024](https://psugffm.odoo.com/pssaturday) ([Agenda](https://sessionize.com/view/c1s08wdj/GridSmart?format=Embed_Styled_Html&isDark=True&title=PSSaturday%20Karlsruhe))

### Abstract

Datenobjekte der allgemeinen Klasse PSCustomObject sind eine gute und häufig genutzte Möglichkeit, zusammengehörende Daten in einer Datenstruktur oder Variable zu speichern. Weniger bekannt ist, dass diesen Objekten mit dem Befehl Add-Member auch Funktionalität hinzugefügt werden kann. Mit dem Typ ScriptProperty lassen sich dynamische Eigenschaften erstellen, z. B. eine FullName-Eigenschaft als Kombination der Eigenschaften FirstName und LastName. Mit dem Typ ScriptMethod können komplexe Methoden implementiert werden, die die Daten des Objekts z. B. in eine Datei schreiben. In diesem Vortrag zeige ich, wie man damit den Code im Hauptprogramm reduzieren und sich auf das Wesentliche konzentrieren kann. Dieser Ansatz eignet sich besonders für kleinere Projekte oder Projekte im Aufbau, bei denen die Verwendung von echten benutzerdefinierten Klassen anfangs oder generell vermieden werden sollte.

Data objects of the general class PSCustomObject are a good and frequently used option for storing data that belongs together in a data structure or variable. What is less well known is that functionality can also be added to these objects using the Add-Member command. The ScriptProperty type can be used to create dynamic properties, for example a FullName property as a combination of the FirstName and LastName properties. The ScriptMethod type can be used to implement complex methods that write the object's data to a file, for example. In the talk, I will show how this can reduce the code in the main program and focus on the essentials. This approach is particularly suitable for smaller projects or projects under construction, where the use of real custom classes should be avoided initially or in general.

### Democode

#### 00_The_task.ps1

Zunächst das im Folgenden verwendete Beispiel: Es ist über eine Anzahl an Dateien zu iterieren. Für den Vortrag natürlich nur eine kleine Anzahl, in echten Projekten sind es dann entweder sehr viele Dateien oder auch ganz andere Datenstrukturen.

First the example used in the following: Iterate over a number of files. For the presentation, of course, only a small number, in real projects there are either a large number of files or completely different data structures.

#### 01_Classic_progress_bar.ps1

Um eine Fortschrittsanzeige zu implementieren, sind viele Zeilen Code notwendig. Das lenkt aus meiner Sicht zu sehr vom eigentlichen, fachlichen Code ab.

Many lines of code are required to implement a progress bar. In my opinion, this distracts too much from the actual functional code.

#### 02_New-MyProgress.ps1

Die ist die im Folgenden genutzte Funktion, um eine "intelligentes Datenobjekt" zu erstellen, dass die Anzahl der im Hauptprogramm zu schreibenden Zeilen erheblich reduziert. Zusätzlich bietet das Objekt weitere Funktionalitäten wie z. B. die Anzeige der Dauer des Vorgangs auch nach der Beendigung der Schleife.

This is the function used in the following to create an "intelligent data object" that significantly reduces the number of lines to be written in the main program. In addition, the object offers further functionalities such as displaying the duration of the process even after the loop has ended.

#### 03_My_progress_bar.ps1

In dieser Art der Verwendung wird die Anzahl der Zeilen nun schon deutlich reduziert und die generelle Verwendung dargestellt.

In this type of usage, the number of lines is already significantly reduced and the general usage is shown.

#### 04_My_progress_bar_compact.ps1

In den meisten Fällen kann die Anzahl an notwendigen Zeilen weiter reduziert werden, da die benötigten Informationen der Methode "Write" direkt mitgegeben werden können.
Damit werden vor der Schleife und zu Beginn der Schleife nur noch jeweils eine Zeile benötigt.

In most cases, the number of required lines can be further reduced, as the required information can be passed directly to the "Write" method.
This means that only one line is required before the loop and at the start of the loop.

#### 05_New-MyCredential.ps1

Diese Funktion soll zeigen, wie das vorgestellte Konzept auch auf andere fachliche Themen angewendet werden kann.

This function is intended to show how the concept presented can also be applied to other specialist topics.

### Fragen der Teilnehmer / Questions from participants

#### Warum wurde keine PowerShell Klasse oder sogar eine .NET Klasse erstellt? / Why was no PowerShell class or even a .NET class created?

Ich habe nach dem Vortrag ChatGPT gebeten, die Funktion in Form einer PowerShell Klasse zu implementieren - was leider keinen lauffähigen Code brachte. Weitere Recherchen haben gezeigt, dass sich insbesondere die verwendete Funktionalität der ScriptProperty nicht in einer Klasse implementieren lässt. Zudem werden generell mehr Zeilen Code benötigt, ich hingegen wollte die Funktionalität mit so wenig Zeilen Code wie möglich umsetzen. Zudem wollte ich ganz absichtlich nur einen ersten kleinen Schritt in Richtung objektorientierter Programmierung gehen, um Kunden anhand dieses Beispiels langsam an das Konzept heranzuführen.

After the presentation, I asked ChatGPT to implement the function in the form of a PowerShell class - which unfortunately did not produce any executable code. Further research has shown that the ScriptProperty functionality in particular cannot be implemented in a class. In addition, more lines of code are generally required, but I wanted to implement the functionality with as few lines of code as possible. I also deliberately wanted to take only a first small step towards object-oriented programming in order to slowly introduce customers to the concept using this example.

#### Gibt es vielleicht schon eine ähnliche Lösung? / Is there perhaps already a similar solution?

Bisher habe ich tatsächlich noch nicht danach gesucht. Eine schnelle Recherche hat das PowerShell Modul [xProgress](https://github.com/themodulecollective/xProgress) geliefert. Da ich in vielen Fällen kein zusätzliches Modul installieren kann oder möchte, werde ich aber zunächst bei meiner Lösung bleiben. Aber vielleicht lasse ich mich von der dortigen Funktionalität weiter inspirieren.

I haven't actually looked for it yet. A quick search returned the PowerShell module [xProgress](https://github.com/themodulecollective/xProgress). Since in many cases I can't or don't want to install an additional module, I will stick with my solution for the time being. But maybe I'll be inspired by the functionality there.