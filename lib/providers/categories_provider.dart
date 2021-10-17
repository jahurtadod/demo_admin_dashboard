import 'package:admin_dashboard/api/cafe_api.dart';
import 'package:admin_dashboard/models/category.dart';
import 'package:admin_dashboard/models/http/categories_response.dart';
import 'package:flutter/material.dart';

class CategoriesProvider extends ChangeNotifier {
  List<Categoria> categorias = [];

  getCategories() async {
    final resp = await CafeApi.httpGet('/categorias');
    final categoriesResponse = CategoriesResponse.fromMap(resp);

    categorias = [...categoriesResponse.categorias];

    print(categorias);

    print(categorias.length);

    notifyListeners();
  }

  Future newCategory(String name) async {
    final data = {'nombre': name};

    try {
      final json = await CafeApi.post('/categorias', data);
      final newCategory = Categoria.fromMap(json);

      categorias.add(newCategory);

      notifyListeners();
    } catch (e) {
      throw 'Error al crear categoria';
    }
  }

  Future updateCategory(String id, String nombre) async {
    final data = {'nombre': nombre};

    try {
      await CafeApi.put('/categorias/$id', data);

      categorias = categorias.map((category) {
        if (category.id != id) return category;

        category.nombre = nombre;
        return category;
      }).toList();

      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar categoria';
    }
  }

  Future deleteCategory(String id) async {
    try {
      await CafeApi.delete('/categorias/$id', {});

      categorias.removeWhere((categoria) => categoria.id == id);

      notifyListeners();
    } catch (e) {
      print(e);
      print('Error al eliminar categoria');
    }
  }
}
