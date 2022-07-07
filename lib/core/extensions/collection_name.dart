String getcCollectionName(String? type) {
  switch (type) {
    case 'engineer':
      return 'engineers';

    case 'client':
      return 'clients';
    case 'company':
      return 'companies';
  }
  return '';
}
