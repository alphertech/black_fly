import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/server_provider.dart';
import '../providers/vpn_provider.dart';
import '../widgets/server_item.dart';

class ServersScreen extends StatefulWidget {
  const ServersScreen({super.key});

  @override
  State<ServersScreen> createState() => _ServersScreenState();
}

class _ServersScreenState extends State<ServersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    context.read<ServerProvider>().loadServers();
  }

  @override
  Widget build(BuildContext context) {
    final serverProvider = context.watch<ServerProvider>();
    final servers = serverProvider.getFilteredServers(
        _selectedFilter, _searchController.text);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Servers'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ServerSearchDelegate(servers),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildFilterChip('All', 'all'),
                const SizedBox(width: 8),
                _buildFilterChip('Recommended', 'recommended'),
                const SizedBox(width: 8),
                _buildFilterChip('Fastest', 'fastest'),
                const SizedBox(width: 8),
                _buildFilterChip('Favorites', 'favorites'),
                const SizedBox(width: 8),
                _buildFilterChip('Europe', 'europe'),
                const SizedBox(width: 8),
                _buildFilterChip('Asia', 'asia'),
                const SizedBox(width: 8),
                _buildFilterChip('Americas', 'americas'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Server count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${servers.length} servers available',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                TextButton(
                  onPressed: () => serverProvider.resetFilters(),
                  child: const Text('Reset'),
                ),
              ],
            ),
          ),
          const Divider(),
          // Server list
          Expanded(
            child: serverProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: servers.length,
                    itemBuilder: (context, index) {
                      return ServerItem(
                        server: servers[index],
                        onConnect: () {
                          _connectToServer(servers[index]);
                        },
                        onFavorite: () {
                          serverProvider.toggleFavorite(servers[index].id);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    return FilterChip(
      label: Text(label),
      selected: _selectedFilter == value,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = selected ? value : 'all';
        });
      },
      backgroundColor: Colors.grey[200],
      selectedColor: Theme.of(context).primaryColor.withAlpha(51),
      checkmarkColor: Theme.of(context).primaryColor,
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter Servers',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
              Container(
              padding: const EdgeInsets.all(16),
              child: const Text('Use top chips for filtering'),
            ),
          ],
        ),
      ),
    );
  }

  void _connectToServer(server) {
    context.read<VPNProvider>().updateLocation(
          '${server.city}, ${server.country}',
          server.ip,
          server.ping,
        );
    context.read<VPNProvider>().connect();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Connecting to ${server.city}, ${server.country}...'),
        duration: const Duration(seconds: 2),
      ),
    );
    Navigator.pop(context);
  }
}

class ServerSearchDelegate extends SearchDelegate {
  final List servers;

  ServerSearchDelegate(this.servers);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = servers
        .where((server) =>
            server.country.toLowerCase().contains(query.toLowerCase()) ||
            server.city.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${results[index].city}, ${results[index].country}'),
          subtitle:
              Text('${results[index].ping} ms • ${results[index].load}% load'),
          leading: Text(results[index].countryCode.toUpperCase()),
          onTap: () {
            close(context, results[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = servers
        .where((server) =>
            server.country.toLowerCase().contains(query.toLowerCase()) ||
            server.city.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title:
              Text('${suggestions[index].city}, ${suggestions[index].country}'),
          subtitle: Text(
              '${suggestions[index].ping} ms • ${suggestions[index].load}% load'),
          leading: Text(suggestions[index].countryCode.toUpperCase()),
          onTap: () {
            close(context, suggestions[index]);
          },
        );
      },
    );
  }
}
