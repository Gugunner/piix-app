import 'package:piix_mobile/general_app_feature/utils/extension/int_extention.dart';

@Deprecated('Will be removed in 4.0')
class PiixCameraCopiesDeprecated {
  static const takePhoto = 'Tomar una foto';
  static const takeAnotherPhoto = 'Tomar otra foto';
  static const confirmAllPhotosDeleted = 'Se ha eliminado todo.';
  static const confirmPhotoDeleted = 'Se ha eliminado la imagen.';
  static const shouldDeleteAllPhotos = '¿Eliminar todo?';
  static const youCannotRecoverPhotos =
      'Se eliminaran todas las imagenes o fotografías del formulario.';
  static const deletePhotoToTakeNew =
      'Elimina una o algunas fotos para tomar una nueva.';
  static const deleteAll = 'Eliminar todo';
  static const delete = 'Eliminar';
  static const photoLimit = 'Límite máximo de fotos';
  static const viewPhotos = 'Ver Fotos';
  static const usePhotos = 'USAR FOTOS';
  static const erase = 'Borrar';
  static const noImageToVisualize =
      'No se encontro ninguna imagen para previsualizar.';
  static const takeNext = 'TOMAR SIGUIENTE';
  static const saveAndExit = 'GUARDAR Y SALIR';
  static const uploadImage = 'O subir una imagen';
  static const uploadAnotherImage = 'Subir otra imagen';
  static const errorFromImagePicker =
      'Error al obtener imágenes desde la galería';
  //PiixCameraDialog Image Catalog
  static const picturesYouHaveTaken =
      'Estas son las fotos que has tomado. Te recomendamos '
      'revisarlas, eliminar las que no uses y confirmar.';
  static String getMinimumPhotosWarning(int minimumPhotos) =>
      'Se requiere un minimo de $minimumPhotos '
      'fotografía${minimumPhotos.pluralWithS}.';
  static String getCurrentPhotos(int networkImagesLength) =>
      'Tienes $networkImagesLength '
      'fotografia${networkImagesLength.pluralWithS}';
  static String changePicture(int networkImagesLength) =>
      'Cambiar fotografia${networkImagesLength.pluralWithS}';
  static String errorImagePickerLength(int maxPhotos) =>
      'El máximo de imágenes a subir es $maxPhotos, intente nuevamente sin '
      'exceder el límite de imágenes.';
  static String cleanImages(int images) =>
      'Limpiar ${images > 1 ? 'imágenes' : 'imagen'}';
  static String cleanPhotos(int photos) => 'Limpiar foto${photos.pluralWithS}';
}
