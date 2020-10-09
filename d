[1mdiff --git a/locallibreria/catalogo/__pycache__/models.cpython-39.pyc b/locallibreria/catalogo/__pycache__/models.cpython-39.pyc[m
[1mindex 126b471..12e14da 100644[m
Binary files a/locallibreria/catalogo/__pycache__/models.cpython-39.pyc and b/locallibreria/catalogo/__pycache__/models.cpython-39.pyc differ
[1mdiff --git a/locallibreria/catalogo/models.py b/locallibreria/catalogo/models.py[m
[1mindex 71a8362..4d0f692 100644[m
[1m--- a/locallibreria/catalogo/models.py[m
[1m+++ b/locallibreria/catalogo/models.py[m
[36m@@ -1,3 +1,76 @@[m
 from django.db import models[m
[32m+[m[32mfrom django.urls import reverse         #redirecciona una url de un libro al browser[m
[32m+[m[32mimport uuid                             #se utilzia para definir atributos clave (PK)[m
 [m
 # Create your models here.[m
[32m+[m[32mclass Genre(models.Model):[m
[32m+[m[32m    #Model representing a book genre."""[m
[32m+[m	[32mname = models.CharField(max_length=200)[m
[32m+[m[41m	[m
[32m+[m	[32mdef __str__(self):[m
[32m+[m		[32mreturn self.name[m
[32m+[m
[32m+[m
[32m+[m[32mclass Book(models.Model):[m
[32m+[m[41m    [m
[32m+[m	[32mtitle = models.CharField(max_length=200)[m
[32m+[m	[32mauthor = models.ForeignKey('Author', on_delete=models.SET_NULL, null=True)[m
[32m+[m[41m    [m
[32m+[m	[32msummary = models.TextField(max_length=1000)[m
[32m+[m	[32misbn = models.CharField('ISBN', max_length=13)[m
[32m+[m	[32mgenre = models.ManyToManyField(Genre)[m
[32m+[m[41m    [m
[32m+[m	[32mdef __str__(self):[m
[32m+[m		[32mreturn self.title[m
[32m+[m[41m    [m
[32m+[m	[32mdef get_absolute_url(self):[m
[32m+[m		[32m"""Returns the url to access a detail record for this book."""[m
[32m+[m		[32mreturn reverse('book-detail', args=[str(self.id)])[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32mclass BookInstance(models.Model):[m
[32m+[m	[32mid = models.UUIDField(primary_key=True, default=uuid.uuid4, help_text='Unique ID for this particular book across whole library')[m
[32m+[m	[32mbook = models.ForeignKey('Book', on_delete=models.SET_NULL, null=True)[m
[32m+[m	[32mimprint = models.CharField(max_length=200)[m
[32m+[m	[32mdue_back = models.DateField(null=True, blank=True)[m
[32m+[m
[32m+[m	[32mLOAN_STATUS = ([m
[32m+[m		[32m('m', 'Maintenance'),[m
[32m+[m		[32m('o', 'On loan'),[m
[32m+[m		[32m('a', 'Available'),[m
[32m+[m		[32m('r', 'Reserved'),[m
[32m+[m	[32m)[m
[32m+[m
[32m+[m	[32mstatus = models.CharField([m
[32m+[m		[32mmax_length=1,[m
[32m+[m		[32mchoices=LOAN_STATUS,[m
[32m+[m		[32mblank=True,[m
[32m+[m		[32mdefault='m',[m
[32m+[m		[32mhelp_text='Book availability',[m
[32m+[m	[32m)[m
[32m+[m
[32m+[m	[32mclass Meta:[m
[32m+[m		[32mordering = ['due_back'][m
[32m+[m
[32m+[m	[32mdef __str__(self):[m
[32m+[m		[32m"""String for representing the Model object."""[m
[32m+[m		[32mreturn f'{self.id} ({self.book.title})'[m
[32m+[m
[32m+[m
[32m+[m[32mclass Author(models.Model):[m
[32m+[m	[32m"""Model representing an author."""[m
[32m+[m	[32mfirst_name = models.CharField(max_length=100)[m
[32m+[m	[32mlast_name = models.CharField(max_length=100)[m
[32m+[m	[32mdate_of_birth = models.DateField(null=True, blank=True)[m
[32m+[m	[32mdate_of_death = models.DateField('Died', null=True, blank=True)[m
[32m+[m
[32m+[m	[32mclass Meta:[m
[32m+[m		[32mordering = ['last_name', 'first_name'][m
[32m+[m
[32m+[m	[32mdef get_absolute_url(self):[m
[32m+[m		[32mreturn reverse('author-detail', args=[str(self.id)])[m
[32m+[m
[32m+[m	[32mdef __str__(self):[m
[32m+[m		[32m"""String for representing the Model object."""[m
[32m+[m		[32mreturn f'{self.last_name}, {self.first_name}'[m
\ No newline at end of file[m
[1mdiff --git a/locallibreria/db.sqlite3 b/locallibreria/db.sqlite3[m
[1mindex 4a6c187..6b1d6ab 100644[m
Binary files a/locallibreria/db.sqlite3 and b/locallibreria/db.sqlite3 differ
